<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Profile</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.5/css/materialize.min.css">
</head>
<body>
<div class="navbar-fixed">
    <nav class="nav-extended">
        <div class="nav-wrapper blue">
            <ul id="slide-out" class="right side-nav">
                <li class="logo center">
                    <img src="https://www.drupal.org/files/profile_default.jpg" alt="" class="circle" width="64" height="64">
                </li>
                <li class="search">
                    <form action="javascript:search(document.getElementById('search1').getElementsByClassName('black-text')[0].value, 0)" autocomplete="off">
                        <div id="search1" class="search-wrapper">
                            <input id="search" class="black-text">
                            <div class="search-results"></div>
                        </div>
                    </form>
                </li>
                <li><a href="${createLink(uri: '/profile')}">Profile</a></li>
                <li><g:link controller="profile" action="friends">Friends</g:link></li>
                <li><g:link controller="profile" action='settings'>Settings</g:link></li>
                <li><a class="red-text" href="<g:createLink action='index' />">Logout</a></li>
            </ul>
            <ul class="right hide-on-med-and-down">
                <li>
                    <form action="javascript:search(document.getElementById('search2').getElementsByClassName('mainSearchBar')[0].value, 1)" autocomplete="off">
                        <div id="search2" class="input-field" style="height: 64px">
                            <input id="searcher" type="search" class="mainSearchBar"/>
                            <label for="searcher"><i class="material-icons">search</i></label>
                            <div class="search-results blue"></div>
                        </div>
                    </form>
                </li>
                <li><g:link controller="profile" action="friends">Friends</g:link></li>
                <li><a href="#">Settings</a></li>
                <li><a href="${createLink(uri: '/')}">Logout</a></li>
            </ul>
            <a href="#" data-activates="slide-out" class="button-collapse right"><i class="material-icons">menu</i></a>

            <a href="${createLink(uri: '/profile')}" class="brand-logo left">Hello, ${session['username'] ?: 'default'}!</a>

        </div>
    </nav>
</div>

<!-- Main Content Start -->
    <g:form resource="${this.Users}" method="PUT">
        <f:field property="Users.password">
            <input name="${property}" type="password" placeholder="Change your password."/>
        </f:field>
        <f:field property="Users.firstName" widget-placeholder="Change your first name."/>
        <f:field property="Users.lastName" widget-placeholder="Change your last name."/>
        <f:field property="Users.gender" widget-placeholder="Change your gender."/>
        <g:submitButton name="Update"/>
    </g:form>
</div>

<!--  Main Content End  -->

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.5/js/materialize.min.js"></script>
<script>
    $(document).ready(function () {
        $('.button-collapse').sideNav();
    })

    $('#textarea1').trigger('autoresize');
</script>
</body>
</html>