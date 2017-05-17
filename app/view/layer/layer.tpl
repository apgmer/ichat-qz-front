<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport"
          content="width=device-width, initial-scale=1">
    <title>IChat</title>

    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="iUAP Design"/>

    <link rel="stylesheet" href="/public/iuap/css/u.css">
    <link rel="stylesheet" href="/public/iuap/css/font-awesome.css">
    <link rel="stylesheet" href="/public/css/style.css">
    <!--[if (gte IE 9)|!(IE)]><!-->
    <script src="/public/jquery/jquery.min.js"></script>
    <!--<![endif]-->
    <!--[if lte IE 8 ]>
    <script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
    <script src="/public/iuap/js/u-polyfill.js"></script>
    <![endif]-->
    <script src="/public/iuap/js/u.js"></script>
</head>
<body>

<nav class="u-navbar u-navbar-inverse" role="navigation">
    <div class="u-container">
        <div class="u-navbar-header">
            <button type="button" class="u-navbar-toggle u-hamburger u-hamburger-close u-collapsed"
                    data-target="#example-inverse-collapse" data-toggle="collapse">
                <!-- <span class="sr-only">Toggle navigation</span> -->
                <span class="u-hamburger-bar"></span>
            </button>

            <a class="u-navbar-brand">IChat</a>
        </div>
        <ul class="nav-list u-navbar-nav hidden-xs">
            <li>
                <a href="/">
                    首页
                </a>
            </li>
        </ul>
        <div class="u-collapse u-navbar-collapse u-navbar-collapse-group">

            <ul class="nav-list u-navbar-toolbar u-navbar-right font-size-14">
                {% if isLogin %}
                    <li><a href="/chat">开始聊天</a></li>
                    <li><a href="/logout">退出</a></li>
                    <li><a href="/notify"><i class="uf uf-bell"></i></a></li>
                {% else %}
                    <li><a href="/login">登陆</a></li>
                    <li><a href="/register">注册</a></li>
                {% endif %}
            </ul>

        </div>
    </div>
</nav>

{% block content %}{% endblock %}
</body>
</html>