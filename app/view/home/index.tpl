<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0"/>
    <title>IChat</title>

    <!-- CSS  -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="/public/materialize/css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
    <link href="/public/css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>
</head>
<body>
<nav class="light-blue lighten-1" role="navigation">
    <div class="nav-wrapper container">
        <a id="logo-container" href="#" class="brand-logo">
            <img src="/public/favicon.png" style="width: 64px;" alt="">
        </a>
        <ul class="right hide-on-med-and-down">
            <li><a href="/login">登录</a></li>
            <li><a href="/register">注册</a></li>
            <li><a href="/family">开始聊天</a></li>
        </ul>

        <ul id="nav-mobile" class="side-nav">
            <li><a href="/login">登录</a></li>
            <li><a href="/register">注册</a></li>
            <li><a href="/family">开始聊天</a></li>
        </ul>
        <a href="#" data-activates="nav-mobile" class="button-collapse"><i class="material-icons">menu</i></a>
    </div>
</nav>
<div class="section no-pad-bot" id="index-banner">
    <div class="container">
        <br><br>
        <h1 class="header center orange-text">IChat</h1>
        <div class="row center">
            <h5 class="header col s12 light">
                专注亲子交流
            </h5>
        </div>
        <div class="row center">
            <a href="/family" id="download-button"
               class="btn-large waves-effect waves-light orange">立即开始</a>
        </div>
        <br><br>

    </div>
</div>


<div class="container">
    <div class="section">

        <!--   Icon Section   -->
        <div class="row">
            <div class="col s12 m4">
                <div class="icon-block">
                    <h2 class="center light-blue-text"><i class="material-icons">flash_on</i></h2>
                    <h5 class="center">快速</h5>

                    <p class="light">
                        方便。用户不需要使用任何插件或者软件就能通过浏览器来实现实时通信。
                        免费。虽然WebRTC技术已经较为成熟，其集成了最佳的音/视频引擎，十分先进的codec，但是Google对于这些技术不收取任何费用。
                        强大的打洞能力。WebRTC技术包含了使用STUN、ICE、TURN、RTP-over-TCP的关键NAT和防火墙穿透技术，并支持代理。
                    </p>
                </div>
            </div>

            <div class="col s12 m4">
                <div class="icon-block">
                    <h2 class="center light-blue-text"><i class="material-icons">group</i></h2>
                    <h5 class="center">专注</h5>

                    <p class="light">By utilizing elements and principles of Material Design, we were able to create a
                        framework that incorporates components and animations that provide more feedback to users.
                        Additionally, a single underlying responsive system across all platforms allow for a more
                        unified user experience.</p>
                </div>
            </div>

            <div class="col s12 m4">
                <div class="icon-block">
                    <h2 class="center light-blue-text"><i class="material-icons">settings</i></h2>
                    <h5 class="center">跨平台</h5>

                    <p class="light">We have provided detailed documentation as well as specific code examples to help
                        new users get started. We are also always open to feedback and can answer any questions a user
                        may have about Materialize.</p>
                </div>
            </div>
        </div>

    </div>
    <br><br>

    <div class="section">

    </div>
</div>

<footer class="page-footer orange">
    <div class="container">
        <div class="row">
            <div class="col l6 s12">
                <h5 class="white-text">郭晓天</h5>
                <p class="grey-text text-lighten-4">2017 毕业设计</p>


            </div>
            <div class="col l3 s12">
                <h5 class="white-text">Settings</h5>
                <ul>
                    <li><a class="white-text" href="#!">Link 1</a></li>
                    <li><a class="white-text" href="#!">Link 2</a></li>
                    <li><a class="white-text" href="#!">Link 3</a></li>
                    <li><a class="white-text" href="#!">Link 4</a></li>
                </ul>
            </div>
            <div class="col l3 s12">
                <h5 class="white-text">Connect</h5>
                <ul>
                    <li><a class="white-text" href="#!">Link 1</a></li>
                    <li><a class="white-text" href="#!">Link 2</a></li>
                    <li><a class="white-text" href="#!">Link 3</a></li>
                    <li><a class="white-text" href="#!">Link 4</a></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="footer-copyright">
        <div class="container">
            Made by <a class="orange-text text-lighten-3" href="http://github.com/apgmer">xiaotian</a>
        </div>
    </div>
</footer>


<!--  Scripts-->
<script src="/public/jquery/dist/jquery.js"></script>
<script src="/public/materialize/js/materialize.js"></script>
<script>
    (function ($) {
        $(function () {

            $('.button-collapse').sideNav();

        }); // end of document ready
    })(jQuery); // end of jQuery name space
</script>
{#<script src="js/init.js"></script>#}

</body>
</html>
