<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Profile</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.5/css/materialize.min.css">
    <script>
        window.onload = function WindowLoad(event) {
            getPosts()
        };

        function getPosts() {
            let req = new XMLHttpRequest();
            req.onreadystatechange = function() {
                if (req.readyState == 4 && req.status == 200) {
                    let res = JSON.parse(req.responseText);
                    console.log(res);
                    console.log(res[0]);
                    document.getElementById('profilePosts').innerHTML = "<br/><br/><div class='container'>" +
                        "   <div class='row'>\n";
                    for (index in res)
                        document.getElementById('profilePosts').innerHTML += "   <div class='col s6 m4 z-depth-2'>" +
                            "           <h5 class='center'>" + res[index].username + "</h5>\n" +
                            "           <p class='center'>" + res[index].message + "</p>\n" +
                            "   </div>\n";

                    document.getElementById('profilePosts').innerHTML += "   </div>\n" +
                        "</div>\n";

                }
            };
            req.open("GET", "http://localhost:9000/posts/all/@username", true);
            req.send(null);
        }

        function search(name, item) {
            let req = new XMLHttpRequest();
            req.onreadystatechange = function() {
                if (req.readyState == 4 && req.status == 200) {
                    let res = JSON.parse(req.responseText);
                    document.getElementsByClassName("search-results").item(item).innerHTML = "";
                    for (index in res)
                        document.getElementsByClassName("search-results").item(item).innerHTML += "<a style='z-index: 5' href='#!'>" + res[index] + "</a>\n"
                }
            };
            req.open("GET", "http://localhost:9000/restful/search/" + name, true);
            req.send(null);
        }

        function post() {
            let msg = document.getElementById('icon_prefix2').value;
            if (msg.length > 0) {
                let req = new XMLHttpRequest();
                req.onreadystatechange = function () {
                    if (req.readyState == 4 && req.status == 200) {
                        let res = JSON.parse(req.responseText);
                        getPosts()
                    }
                };
                req.open("POST", "http://localhost:9000/post", true);
                let obj = {
                    "username": "@username",
                    "message": msg
                };
                req.send(JSON.stringify(obj));
                document.getElementById('icon_prefix2').value = ""
            }
        }
    </script>
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
                <li><a href="#">Profile</a></li>
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
                <li><g:link controller="profile" action="settings">Settings</g:link></li>
                <li><a href="${createLink(uri: '/')}">Logout</a></li>
            </ul>
            <a href="#" data-activates="slide-out" class="button-collapse right"><i class="material-icons">menu</i></a>

            <g:link controller="profile" action="index" class="brand-logo left">Hello, ${session['username'] ?: 'default'}!</g:link>

        </div>
    </nav>
</div>

<!-- Main Content Start -->

<div class="row">
    <g:form class="col s12" id="postForm" action="post">
        <div class="row">
            <div class="input-field col s12">
                %{--<g:link class="btn-floating halfway-fab waves-effect waves-light blue" style="float: right"><i class="material-icons prefix">send</i></g:link>--}%
                <g:textField id="icon_prefix2" class="materialize-textarea" style="overflow: hidden; padding-right: .5em;" name="comment">Post your thoughts...</g:textField>
                <label for="icon_prefix2">Message</label>
            </div>
        </div>
    </g:form>
</div>

<div id="profilePosts"></div>

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