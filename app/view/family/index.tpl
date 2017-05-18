<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="基于Material Design的主流前端响应式框架">
    <title>IChat - 家庭管理</title>

    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="/public/materialize/css/materialize.min.css">
    <link rel="stylesheet" href="/public/css/ghpages-materialize.css">

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
        <li class="bold active"><a href="/family" class="waves-effect waves-teal">家庭管理</a></li>
        <li class="bold "><a href="/family/chat" class="waves-effect waves-teal">开始聊天</a></li>
        <li class="bold"><a href="/logout" class="waves-effect waves-teal">退出登录</a></li>

    </ul>
</header>
<main>
    <div class="section" id="index-banner">
        <div class="container">
            <div class="row">
                <div class="col s12 m9">
                    <h1 class="header center-on-small-only">家庭管理</h1>
                </div>
                <div class="col s12 m3">

                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <!--  Outer row  -->
        <div class="row">
            <div class="col s12 m9 l10">

                <div class="addBtn" style="padding-top: 10px;padding-bottom: 10px">
                    <a class="btn-floating btn-large waves-effect waves-light red" href="#modal1">
                        <i class="material-icons">add</i>
                    </a>
                    添加成员

                    <div id="modal1" class="modal" style="width: 35%;">
                        <div class="modal-content">
                            <h4>添加成员</h4>


                            <form action="">
                                <div class="row margin">
                                    <div class="input-field col s12">
                                        <i class=" prefix material-icons">stay_current_portrait</i>
                                        <input id="phone" name="phone" type="text" class="validate">
                                        <label for="phone" class="center-align">手机号码</label>
                                    </div>
                                </div>
                                <div class="row margin">
                                    <div class="input-field col s12">
                                        <i class="material-icons prefix">account_circle</i>
                                        <input id="nickname" name="nickname" type="text" class="validate">
                                        <label for="nickname" class="center-align">名称</label>
                                    </div>
                                </div>
                                <div class="row margin">
                                    <div class="input-field col s12">
                                        <i class="material-icons prefix">accessibility</i>
                                        <select name="role">
                                            <option value="" disabled selected>选择</option>
                                            <option value="1">妈妈</option>
                                            <option value="2">爸爸</option>
                                            <option value="3">儿子</option>
                                            <option value="4">女儿</option>
                                        </select>
                                        <label>角色</label>
                                    </div>
                                </div>
                                <div class="row margin">
                                    <div class="input-field col s12">
                                        <i class="material-icons prefix">lock_outline</i>
                                        <input id="password" name="pass" type="password" class="validate">
                                        <label for="password">密码</label>
                                    </div>
                                </div>
                                <div class="row margin">
                                    <div class="input-field col s12">
                                        <i class="material-icons prefix">lock_outline</i>
                                        <input id="password-again" name="password2" type="password">
                                        <label for="password-again">重复密码</label>
                                    </div>
                                </div>
                            </form>

                        </div>
                        <div class="modal-footer">
                            <a href="javascript:$('form').submit()" class="modal-action modal-close waves-effect waves-green btn-flat ">提交</a>
                        </div>
                    </div>
                </div>

                <ul class="collection">

                    {% for mem in memInfos %}

                        <li class="collection-item">
                            <span class="title">{{ mem.nickname }}</span>
                            <p>角色：
                                {% if mem.role == '1' %}
                                    妈妈
                                {% elseif mem.role == '2' %}
                                    爸爸
                                {% elseif mem.role == '3' %}
                                    儿子
                                {% elseif mem.role == '4' %}
                                    女儿
                                {% endif %}
                                <br>
                                {{ mem.phone }}
                            </p>
                            <a href="javascript:;" onclick="delMem('{{ mem.id }}')">删除</a>
                        </li>

                    {% else %}
                        查询出错
                    {% endfor %}
                </ul>
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

<script>
    var delMem = function (memId) {

        var userid = '{{ ctx.session.user.id }}'
        if(userid == memId){
            Materialize.toast('不能删除自己哦。', 3000)
            return false;
        }

        $.get("/family/delMem?id=" + memId,function (res) {
            if (res.success){
                Materialize.toast('删除成功。', 3000,'',function () {
                    location.reload()
                })
            }else{
                Materialize.toast('删除失败请重试。', 3000)
            }
        })

    }

    $(function () {
        $('form').submit(function () {
            if($('#password').val() !== $('#password-again').val()){
                Materialize.toast('两次密码不同', 4000)
                return false;
            }
            var phone = $('#phone').val()
            var reg = /^1[3|4|5|7|8][0-9]{9}$/; //验证规则
            if (!reg.test(phone)) {
                Materialize.toast('手机号码不正确', 4000) // 4000 is the duration of the toast
                return
            }
            let data = $(this).serializeArray();
            $.post("/family/addMem",data,function (res) {
                if (res.success){
                    Materialize.toast('添加成功。', 3000,'',function () {
                        location.reload()
                    })
                }else{
                    Materialize.toast('添加失败请重试。', 3000)
                }
            })
            return false;
        })
    })
</script>

</body>
</html>