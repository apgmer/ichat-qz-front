<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>注册</title>
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
    <div class="col s12 z-depth-6 card-panel" style="min-width: 450px;">
        <form class="login-form">
            <div class="row">
                <div class="input-field col s12 center">
                    <img src="/public/favicon.png" width="100px" alt="" class="responsive-img valign profile-image-login">
                    <p class="center login-form-text">注册</p>
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
                    <i class="material-icons prefix">code</i>
                    <input id="regcode" name="regcode" type="text" class="validate">
                    <label for="regcode" class="center-align">验证码</label>
                    <a href="javascript:;" id="sendBtn" onclick="sendRegCode()" style="position: absolute; top:0; right: 12px;">发送验证码</a>
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
                    </select>
                    <label>角色</label>
                </div>
            </div>
            <div class="row margin">
                <div class="input-field col s12">
                    <i class="material-icons prefix">lock_outline</i>
                    <input id="password" name="password" type="password" class="validate">
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
            <div class="row">
                <div class="input-field col s12">
                    <button type="submit" class="btn waves-effect waves-light col s12">  立即注册  </button>
                </div>
                <div class="input-field col s12">
                    <p class="margin center medium-small sign-up">Already have an account? <a href="login.html">Login</a></p>
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
    $(document).ready(function() {
        $('select').material_select();


        $('form').submit(function () {
            if($('#password').val() !== $('#password-again').val()){
                Materialize.toast('两次密码不同', 4000)
                return false;
            }
            let data = $(this).serializeArray();
            $.post('/reguser',data,function (res) {
                if (res.success){
                    Materialize.toast('注册成功，请登陆 .', 1000,'',function () {
                        window.location.href = '/login';
                    })
                }else{
                    Materialize.toast('注册失败，重复的用户名 或 验证码错误', 4000,'',function () {
                        location.reload();
                    })
                }
            });
            return false;
        })

    });
    var sendRegCode = function () {

        var _csrf = '{{ ctx.csrf }}'

        var phone = $('#phone').val()
        var reg = /^1[3|4|5|7|8][0-9]{9}$/; //验证规则
        if (!reg.test(phone)) {
            Materialize.toast('手机号码不正确', 4000) // 4000 is the duration of the toast
            return
        }

        $('#sendBtn').hide()
        $.post('/regcode',{phone:phone,_csrf:_csrf},function (res) {
            if (res.success){
                Materialize.toast('发送成功,若未收到60s后重新发送', 60000,'',function () {
                    $('#sendBtn').show()
                }) // 4000 is the duration of the toast
            }else{
                Materialize.toast('发送失败', 1000,'',function () {
                    window.location.reload();
                }) // 4000 is the duration of the toast
            }
        })
    }
</script>


</body>

</html>