<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>登录</title>
    <!-- CORE CSS-->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="/public/materialize/css/materialize.min.css">

    <style type="text/css">
        html,
        body {
            height: 100%;
        }
        html {
            display: table;
            margin: auto;
        }
        body {
            display: table-cell;
            vertical-align: middle;
        }
        .margin {
            margin: 0 !important;
        }
    </style>

</head>

<body class="blue">


<div id="login-page" class="row">
    <div class="col s12 z-depth-6 card-panel">
        <form class="login-form" method="">
            <div class="row">
                <div class="input-field col s12 center">
                    <img src="/public/favicon.png" width="100px" alt="" class="responsive-img valign profile-image-login">
                    <p class="center login-form-text">登录</p>
                </div>
            </div>
            <div class="row margin">
                <div class="input-field col s12">
                    <i class=" prefix material-icons">stay_current_portrait</i>
                    <input id="phone" name="phone" type="text" class="validate">
                    <label for="phone" class="center-align">手机号码</label>
                </div>
            </div>

            <div class="row margin">
                <div class="input-field col s12">
                    <i class="material-icons prefix">lock_outline</i>
                    <input id="password" name="password" type="password" class="validate">
                    <label for="password">密码</label>
                </div>
            </div>

            <div class="row">
                <div class="input-field col s12">
                    <button type="submit" class="btn waves-effect waves-light col s12">立即登录</button>
                </div>
                <div class="input-field col s12">
                    <p class="margin center medium-small sign-up">还未拥有账户，立即注册 <a href="/register">注册</a></p>
                </div>
            </div>
        </form>
    </div>
</div>



<!-- jQuery Library -->
<script type="text/javascript" src="/public/jquery/dist/jquery.min.js"></script>
<!--materialize js-->
<script src="/public/materialize/js/materialize.min.js"></script>


<script>
    $('form').submit(function(){
        let data = $(this).serializeArray();
        $.post('/login',data,function (res) {
            if (res.success){
                Materialize.toast('登录成功', 3000,'',function () {
                    location.href = "/family"
                }) // 4000 is the duration of the toast
            }else{
                Materialize.toast('登录失败', 1000,'',function () {
                    window.location.reload();
                }) // 4000 is the duration of the toast
            }
        });
        return false;
    })
</script>

</body>

</html>