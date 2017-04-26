<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Profile</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.5/css/materialize.min.css">
    <style>
        .tabs .indicator {
            background-color: white;
            height: 5px;
        }
    </style>
    <script>
        window.onload = function WindowLoad(event) {
            getProfile();
            getRecs();
        };

        function getRecs() {
            let req = new XMLHttpRequest();
            req.onreadystatechange = function() {
                if (req.readyState === 4 && req.status === 200) {
                    let res = JSON.parse(req.responseText);
                    document.getElementById('friendRec').innerHTML = "<br/><br/><div class='container'>" +
                        "   <div class='row'>\n";
                    for (index in res)
                        document.getElementById('friendRec').innerHTML += "   <div class='col s12 m4 z-depth-2'>" +
                            "       <div class='icon-block'>" +
                            "           <h2 class='center'><img src=\"https://www.drupal.org/files/profile_default.jpg\" alt=\"\" class=\"circle\" width='42' height='42'></h2>\n" +
                            "           <h5 class='center'>" + res[index] + "</h5>\n" +
                            "           <p class='center'>" +
                            "               <a href='${createLink(controller: "profile", url: "/profile/friends/", action: "addFriend")}"+res[index]+"' class=\"btn-floating halfway-fab waves-effect waves-light blue\"><i class=\"material-icons\">add</i></a>" +
                            "           </p>\n" +
                            "       </div>\n" +
                            "   </div>\n";

                    document.getElementById('friendRec').innerHTML += "   </div>\n" +
                        "</div>\n";
                }
            };
            req.open("GET", "http://localhost:8080/restful/recommend/${session['username']}", true);
            req.send(null);
        }

        function search(name, item) {
            let req = new XMLHttpRequest();
            req.onreadystatechange = function() {
                if (req.readyState === 4 && req.status === 200) {
                    let res = JSON.parse(req.responseText);
                    document.getElementsByClassName("search-results").item(item).innerHTML = "";
                    for (index in res)
                        document.getElementsByClassName("search-results").item(item).innerHTML += "<a style='z-index: 5' href='#!'>" + res[index] + "</a>\n"
                }
            };
            req.open("GET", "http://localhost:8080/restful/search/" + name, true);
            req.send(null);
        }

        function formatC(j) {
            let json = j['confirmed'];
            let list = "<br/><br/><div class='container'>" +
                "   <div class='row'>\n";
            for (index in json) {
                list += "   <div class='col s12 m4 z-depth-2'>" +
                    "       <div class='icon-block'>" +
                    "           <h2 class='center'><img src=\"https://www.drupal.org/files/profile_default.jpg\" alt=\"\" class=\"circle\" width='42' height='42'></h2>\n" +
                    "           <h5 class='center'>" + json[index].toString() + "</h5>\n" +
                    "       </div>\n" +
                    "   </div>\n";
            }
            list += "   </div>\n" +
                "</div>\n";
            return list;
        }

        function formatP(j) {
            let json = j['pending'];
            let list = "<br/><br/><div class='container'>" +
                "   <div class='row'>\n";
            for (index in json) {
                list += "   <div class='col s12 m4 z-depth-2'>" +
                    "       <div class='icon-block'>" +
                    "           <h2 class='center'><img src=\"https://www.drupal.org/files/profile_default.jpg\" alt=\"\" class=\"circle\" width='42' height='42'></h2>\n" +
                    "           <h5 class='center'>" + json[index].toString() + "</h5>\n" +
                    "           <p class='center'>" +
                    "               <a onclick=\"updateFriends('" + json[index].toString() + "', 'PUT')\" class=\"btn-floating halfway-fab waves-effect waves-light blue\"><i class=\"material-icons\">add</i></a>" +
                    "               <a onclick=\"updateFriends('" + json[index].toString() + "', 'DELETE')\" class=\"btn-floating halfway-fab waves-effect waves-light red\"><i class=\"material-icons\">remove</i></a>\n" +
                    "           </p>\n" +
                    "       </div>\n" +
                    "   </div>\n";
            }
            list += "   </div>\n" +
                "</div>\n";
            return list;
        }

        function formatR(j) {
            let json = j['requested'];
            let list = "<br/><br/><div class='container'>" +
                "   <div class='row'>\n";
            console.log(json);
            for (index in json) {
                list += "   <div class='col s12 m4 z-depth-2'>" +
                    "       <div class='icon-block'>" +
                    "           <h2 class='center'><img src=\"https://www.drupal.org/files/profile_default.jpg\" alt=\"\" class=\"circle\" width='42' height='42'></h2>\n" +
                    "           <h5 class='center'>" + json[index].toString() + "</h5>\n" +
                    "       </div>\n" +
                    "   </div>\n";
            }
            list += "   </div>\n" +
                "</div>\n";
            return list;
        }

        function getProfile() {
            let req = new XMLHttpRequest();
            req.onreadystatechange = function() {
                if (req.readyState == 4 && req.status == 200) {
                    let res = JSON.parse(req.responseText);

                    document.getElementById('friend').innerHTML = "";
                    document.getElementById('request').innerHTML = "";
                    document.getElementById('pending').innerHTML = "";

                    document.getElementById('friend').innerHTML = (res.confirmed.length != 0) ? formatC(res) : "<p class='center blue-text' style='font-size: 24px'>No Friends Yet :/</p>";
                    document.getElementById('pending').innerHTML = (res.requested.length != 0) ? formatR(res) : "<p class='center blue-text' style='font-size: 24px'>No Friend Requests Sent :/</p>";
                    document.getElementById('request').innerHTML = (res.pending.length != 0) ? formatP(res) : "<p class='center blue-text' style='font-size: 24px'>No Friend Requests Yet :/</p>";
                    if (res.message !== null && res.message !== undefined)
                        document.getElementsByClassName('search-results').innerHTML = res.message;
                }
            };
            req.open("GET", "http://localhost:8080/restful/profile/${session['username']}", true);
            req.send(null);
        }

        function updateFriends(user, request) {
            let req = new XMLHttpRequest();
            req.onreadystatechange = function() {
                if (req.readyState == 4 && req.status == 200) {
                    getProfile("");
                    getRecs();
                }
            };
            req.open(request, "http://localhost:8080/profile/friends/" + user, true);
            req.send(null);
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
                <li><a href="${createLink(uri: '/profile')}">Profile</a></li>
                <li><g:link action="friends">Friends</g:link></li>
                <li><g:link action='settings'>Settings</g:link></li>
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
                <li><a href="#">Friends</a></li>
                <li><g:link action='settings'>Settings</g:link></li>
                <li><a href="${createLink(uri: '/')}">Logout</a></li>
            </ul>
            <a href="#" data-activates="slide-out" class="button-collapse right"><i class="material-icons">menu</i></a>

            <a href="${createLink(uri: '/profile')}" class="brand-logo left">Hello, ${session['username'] ?: 'default'}!</a>

        </div>
        <div class="nav-content">
            <ul class="tabs tabs-transparent blue">
                <li class="tab"><a class="white-text" href="#friend">Friends</a></li>
                <li class="tab"><a class="active white-text" href="#request">Pending Requests</a></li>
                <li class="tab"><a class="white-text" href="#pending">Requests Sent</a></li>
            </ul>
        </div>
    </nav>
</div>

<br/><br/>

<div id="friend" class="col s12"></div>
<div id="request" class="col s12"></div>
<div id="pending" class="col s12"></div>

<!-- Main Content Start -->

<br/><br/><br/>
<div class="divider"></div>
<div class="row">
    <div class="center z-depth-2 white-text blue lighten-1" style="font-size: 24px">Recommendations</div>
    <div id="friendRec"></div>
</div>

<!--  Main Content End  -->

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.5/js/materialize.min.js"></script>
<script>
    $(document).ready(function () {
        $('.button-collapse').sideNav();
    });

    $('#textarea1').trigger('autoresize');
</script>
</body>
</html>