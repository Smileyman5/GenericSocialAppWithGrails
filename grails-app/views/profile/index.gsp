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

        function getComments(post) {
            console.log(post);
            let comments = post['comments'];
            let html = "";
            for (index in comments) {
                html += "               <div style='padding: 0; margin: 0; height: 2px' class='gray divider'></div>" +
                    "               <div style='padding: 0 0 0 5px; margin: 0; text-align: left'>" + comments[index]['username'] + "</div>\n" +
                    "               <div style='text-align: left; padding: 0 0 0 20px; font-size:18px'>" + comments[index]['comment'] + "</div>\n ";
            }
            return html;
        }
        function getPosts() {
            let req = new XMLHttpRequest();
            req.onreadystatechange = function() {
                if (req.readyState === 4 && req.status === 200) {
                    let res = JSON.parse(req.responseText);
                    document.getElementById('profilePosts').innerHTML = "<br/><br/><div class='container'>" +
                        "   <div class='row'>\n";

                    for (index in res['posts'])
                        document.getElementById('profilePosts').innerHTML += "   <div style='margin-left: 10%; width: 80%; margin-top: 30px' class='z-depth-2 center'>" +
                            "           <img src='https://www.drupal.org/files/profile_default.jpg' alt='' class='circle left' style='padding: 5px 0 0 5px' width='24' height='24'>\n" +
                            "           <h5 style='padding-left: 32px; margin: 0; text-align: left' class='icon_prefix'>" + res['posts'][index].user + "</h5>\n" +
                            "               <div style='padding: 0; margin: 0; height: 1px' class='black divider'></div>" +
                            "           <p class='center'>" + res['posts'][index].msg + "</p>\n" +
                            "           <p class='bottom' style='font-size: 8px; text-align: right; padding-right: 3px'> Posted at: " + res['posts'][index].timestamp + "</p>\n" +
                            "               <div style='padding: 0; margin: 0; height: 2px' class='gray divider'></div>" +
                            '           <g:form class="col s12" controller="posting" action="addCommentOrLike" method="post">'+
                            '               <div class="input-field col s12 row">' +
                            '                   <input type="hidden" name="postId" value="' + res['posts'][index].id + '"/>'+
                            '                   <g:textField id="icon_prefix2" autocomplete="off" spellcheck="on" class="materialize-textarea" style="overflow: hidden; padding: 0 .5em 0 0; width: 90%; font-size: 20px" name="comment">Post your thoughts...</g:textField>'+
                            '                   <label for="icon_prefix2"><i class="tiny material-icons">comment</i>Comment</label>' +
                            '               </div>'+
                            '           </g:form>' +
                            "           <div class='comment' style='inline-block'> " +
                                        getComments(res['posts'][index]) +
                            "           </div>\n" +
                            "   </div>\n";

                    document.getElementById('profilePosts').innerHTML += "   </div>\n" +
                        "</div>\n";
                }
            };
            req.open("GET", "http://localhost:8080/profile/post/postForm", true);
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

        function post() {
            let msg = document.getElementById('icon_prefix2').value;
            if (msg.length > 0) {
                let req = new XMLHttpRequest();
                req.onreadystatechange = function () {
                    if (req.readyState === 4 && req.status === 200) {
                        let res = JSON.parse(req.responseText);
                        getPosts()
                    }
                };
                req.open("POST", "http://localhost:8080/post", true);
                let obj = {
                    "username": "${session['username']}",
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
                <li><a class="red-text" href="${createLink(uri: '/')}">Logout</a></li>
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
    <g:form class="col s12" id="postForm" controller="profile" action="post" method="post">
        <div class="row">
            <div class="input-field col s12">
                %{--<g:link class="btn-floating halfway-fab waves-effect waves-light blue" style="float: right"><i class="material-icons prefix">send</i></g:link>--}%
                <g:textField id="icon_prefix2" autocomplete="off" spellcheck="on" class="materialize-textarea" style="overflow: hidden; padding-right: .5em;" name="comment">Post your thoughts...</g:textField>
                <label for="icon_prefix2">Message</label>
            </div>
        </div>
    </g:form>
</div>

<div id="profilePosts" style="margin-bottom: 50px"></div>

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