<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="基于Material Design的主流前端响应式框架">
    <title>IChat - 开始聊天</title>

    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="/public/materialize/css/materialize.min.css">
    <link rel="stylesheet" href="/public/css/ghpages-materialize.css">
    <link rel="stylesheet" href="/public/layer/skin/default/layer.css">

</head>
<body>
<style>
    ul.side-nav.fixed li .userView a {
        padding: 0 0;
    }
</style>
<header>
    <div class="container">
        <a href="#" data-activates="nav-mobile"
           class="button-collapse top-nav waves-effect waves-light circle hide-on-large-only"><i
                    class="material-icons">menu</i></a>
    </div>

    <ul id="nav-mobile" class="side-nav fixed">
        <li>
            <div class="userView">
                <div class="background">
                    <img src="/public/imgs/office.jpg">
                </div>
                <a href="#"><img class="circle" src="/public/imgs/yuna.jpg"></a>
                <a href="#"><span class="white-text name">{{ ctx.session.user.nickname }}</span></a>
                <a href="#"><span class="white-text email">{{ ctx.session.user.phone }}</span></a>
            </div>
        </li>
        <li class="bold "><a href="/family" class="waves-effect waves-teal">家庭管理</a></li>
        <li class="bold active"><a href="/family/chat" class="waves-effect waves-teal">开始聊天</a></li>
        <li class="bold"><a href="/logout" class="waves-effect waves-teal">退出登录</a></li>

    </ul>
</header>
<script>
    var loginUserId = '{{ ctx.session.user.id }}'
</script>
<main>
    <div class="section" id="index-banner">
        <div class="container">
            <div class="row">
                <div class="col s12 m9">
                    <h1 class="header center-on-small-only">开始聊天</h1>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <!--  Outer row  -->
        <div class="row">
            <div class="col s3">

                <ul class="collapsible" data-collapsible="accordion">

                    {% for mem in memInfos %}

                        {% if mem.familyUserEntity.id != ctx.session.user.id %}
                            <li>
                                <div class="collapsible-header">
                                    {% if mem.status == 'ONLINE' %}
                                        <span class="new badge green" data-badge-caption="在线"></span>
                                    {% else %}
                                        <span class="new badge red" data-badge-caption="离线"></span>
                                    {% endif %}

                                    <span id="{{ mem.familyUserEntity.id }}">{{ mem.familyUserEntity.nickname }}</span>
                                </div>
                                <div class="collapsible-body">
                                    <button class="waves-effect waves-light btn"
                                            onclick="callTo('{{ mem.familyUserEntity.id }}')"
                                            {% if mem.status == 'OFFLINE' %}
                                        disabled="disabled" {% endif %}>
                                        <i class="material-icons">phone</i>
                                    </button>
                                </div>
                            </li>
                        {% endif %}
                    {% else %}
                        暂无 请添加家庭成员
                    {% endfor %}

                </ul>

            </div>

            <style>
                .video .remoteVideo {
                    width: 100%;
                    max-height: 500px;
                }

                .video .localVideo {
                    position: absolute;
                    width: 25%;
                    bottom: 100px;
                    right: 25px;
                }
                #mapContainer {width:100%; height: 400px; }
            </style>

            <div class="col s9" id="chatPanel">
                {#<div id="mapContainer" tabindex="0"></div>#}
            </div>


        </div>
    </div> <!-- End Container -->
</main>
<footer class="page-footer">
    <div class="container">
        <div class="footer-copyright">
            <div class="container">
                郭晓天2017 毕业设计.
            </div>
        </div>
    </div>
</footer>
<!-- count -->

<!--  Scripts-->
<!-- jQuery Library -->
<script type="text/javascript" src="/public/jquery/dist/jquery.min.js"></script>
<!--materialize js-->
<script src="/public/materialize/js/materialize.min.js"></script>
<script src="/public/js/init.js"></script>
<script src="/public/socketio/socket.io-1.2.1.js"></script>
<script src="/public/layer/layer.js"></script>
<script type="text/javascript" src="https://webapi.amap.com/maps?v=1.3&key=ec38ac6c94ec7a13cdacff6d33ea93d7"></script>
<script src="/public/js/map.js"></script>

<script>
    var startChat = function (uid,isMobile) {
        $('#chatPanel').empty();
        var name = $('#' + uid + '').text()
        var ele =
            '<div class="card grey darken-1">' +
            '<div class="card-content white-text">' +
            '<span class="card-title">与 ' + name + ' 聊天中</span>' +
            '<div class="video">' +
            '<video id="remoteVideo" class="remoteVideo" autoplay ></video>' +
            '<video id="localVideo" class="localVideo" autoplay  style="max-height: 412px;"></video>' +
            '</div>' +
            '</div>' +
            '<div class="card-action">' +
            '<a href="javascript:leave()">挂断</a>' +
            '</div>' +
            '</div>'

        $('#chatPanel').append(ele);
        if (isMobile){
            var mapElem = '<div class="card grey darken-1">' +
                '<div class="card-content white-text">' +
                '<span class="card-title"> ' + name + ' 的地理位置</span>' +
                '<div id="mapContainer" tabindex="0">' +
                '</div>' +
                '</div>' +
                '</div>'
            $('#chatPanel').append(mapElem);
            initMap()
        }

    }
</script>


<script src="/public/js/chat_stand2.js"></script>
<script>
    setInterval(function () {
        $.get("/keepOnline")
    }, 20000)
</script>

</body>
</html>