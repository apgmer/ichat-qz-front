{% extends "../layer/layer.tpl" %}

{% block content %}
    <style>
        video {
            background: black;
            border: 1px solid gray;
        }
    </style>
    <link rel="stylesheet" href="/public/layer/skin/default/layer.css">
    <script src="/public/layer/layer.js"></script>
    <div class="u-container">
        <div class="u-row">

            <div class="u-col-md-4">
                <div class="u-panel">
                    <div class="u-panel-heading">
                        <p class="u-panel-title">我的好友</p>
                    </div>
                    <div class="u-panel-body">
                        <ul class="u-list-group">

                            <li class="u-list-group-item">
                                <form action="" id="searchform">
                                    <div class="form-group form-material floating">
                                        <div class="u-text">
                                            <input type="text" name="search" id="searchKey" class="u-input"
                                                   placeholder="搜索"/>
                                        </div>
                                    </div>
                                </form>
                            </li>

                            {% for friend in friends %}
                                <li class="u-list-group-item">
                                    <div class="friend">
                                        <span style="font-size: 25px;" id="{{ friend.userinfo.id }}">
                                            {{ friend.userinfo.name }}</span>

                                        {% if friend.status == 'ONLINE' %}
                                            <span style="padding-top: 10px" class="u-right"> 在线
                                                <i style="color: #70da4f" class="fa fa-lightbulb-o fa-2x"
                                                   aria-hidden="true"></i>
                                            </span>

                                        {% else %}
                                            <span style="padding-top: 10px" class="u-right"> 离线
                                                <i style="color: #7e7f80;" class="fa fa-lightbulb-o fa-2x"
                                                   aria-hidden="true"></i>
                                            </span>
                                        {% endif %}

                                    </div>
                                    <div class="act">
                                        <button class="u-button u-button-primary u-button-sm"
                                                onclick="callTo('{{ friend.userinfo.id }}')"
                                                {% if friend.status == 'OFFLINE' %} disabled="disabled" {% endif %} >
                                            <i class="fa fa-phone" aria-hidden="true"></i>
                                        </button>
                                    </div>
                                </li>

                            {% else %}
                                <li class="u-list-group-item">还未添加好友，请添加</li>
                            {% endfor %}

                        </ul>

                    </div>
                </div>
            </div>
            <style>
                .videos {
                    /*position: absolute;*/
                }

                .videos .localVideo {
                    width: 100%;
                }

                .videos .remoteVideo {
                    position: absolute;
                    width: 34%;
                    top: 253px;
                    right: 28px;
                }
            </style>
            <div class="u-col-md-8" id="chatPanel">
                <div style="padding-top: 50px">
                    选择好友开始聊天
                </div>
            </div>
        </div>
    </div>
    <script>
        var showUserListDialog = function (data) {
            if (window.userListDialog) {
                return false;
            }
            window.userListDialog = u.messageDialog({
                msg: data,
                title: "搜索结果",
                onOk: function () {
                }
            });
            $(window.userListDialog.contentDom).parents('.u-msg-dialog').css('width', 'auto')
        }
        var closeUserListDialog = function () {
            window.userListDialog.close();
            window.userListDialog = null;
        }

        var showMsg = function (msg) {
            window.msgDialog = u.messageDialog({
                msg: msg,
                title: "提示",
            })
        }
        var closeMsg = function () {
            window.msgDialog.close();
        }
        var addFriend = function (userid) {
            console.log(userid)
            $.get("/friend/addfriendreq", {friendid: userid}, function (res) {
                if (res.success) {
                    closeUserListDialog();
                    showMsg("已发送申请")
                } else {
                    alert("操作失败,可能已经是您的好友了")
                }
            })
        }
        $(function () {
            $('#searchform').submit(function () {

                $.get('/friend/search', {name: $('#searchKey').val()}, function (res) {
                    let tableData = '';
                    for (let i = 0; i < res.length; i++) {
                        tableData += '<tr>' +
                            '<td>' + res[i].userinfo.name + '</td>' +
                            '<td>' + res[i].status + '</td>' +
                            '<td><a href="javascript:;" onclick="addFriend(\'' + res[i].userinfo.id + '\')">添加好友</a></td>' +
                            '</tr>'
                    }

                    let table = '<table class="u-table-base u-table-hover">' +
                        '<tr>' +
                        '<td>用户名</td>' +
                        '<td>在线状态</td>' +
                        '<td>操作</td>' +
                        '</tr>' +
                        tableData +
                        '</table>'

                    showUserListDialog(table);
                })
                return false;
            })

            setInterval(function () {
                $.get('/keeponline')
            }, 10000)

        })
        var startCart = function (uid) {
            $('#chatPanel').empty();
            var name = $('#'+uid+'').text()
            var ele = '<div class="u-panel">' +
                '<div class="u-panel-heading">' +
                '<p class="u-panel-title">与 '+name+' 聊天</p>' +
                '</div>' +
                '<div class="u-panel-body">' +
                '<div class="videos">' +
                '<video id="remoteVideo" class="remoteVideo" autoplay></video>' +
                '<video id="localVideo" class="localVideo" autoplay style="max-height: 412px;"></video>' +
                '</div>' +
                '</div>' +
                '</div>';
            $('#chatPanel').append(ele);
        }
    </script>
    <script src="/public/socketio/socket.io-1.2.1.js"></script>
    <script src="/public/js/chat_stand.js"></script>
{% endblock %}