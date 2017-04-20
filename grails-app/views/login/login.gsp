<!DOCTYPE html>
<html lang="en">

<head>
    <asset:stylesheet src="myapp.css"/>
    <asset:javascript src="myapp.js"/>

    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.5/css/materialize.min.css">
    <style>
    body {
        display: flex;
        min-height: 100vh;
        flex-direction: column;
    }

    main {
        flex: 1 0 auto;
    }

    body {
        background: #fff;
    }

    .input-field input[type=date]:focus + label,
    .input-field input[type=text]:focus + label,
    .input-field input[type=email]:focus + label,
    .input-field input[type=password]:focus + label {
        color: #e91e63;
    }

    .input-field input[type=date]:focus,
    .input-field input[type=text]:focus,
    .input-field input[type=email]:focus,
    .input-field input[type=password]:focus {
        border-bottom: 2px solid #e91e63;
        box-shadow: none;
    }
    </style>
    <script>
        function login() {
            if (document.getElementById("username").value.length > 1 && document.getElementById("password").value.length > 1) {
                var req = new XMLHttpRequest();
                req.onreadystatechange = function () {
                    if (req.readyState == 4 && req.status == 200) {
                        var res = JSON.parse(req.responseText);
                        if (res.failed) {
                            document.getElementById('message').innerHTML = "<p style='color: red'>Username/Password is incorrect</font><br><br>";
                        }
                        else if (res.loggedin) {
                            updateStats();
                        }
                        document.getElementById('password').value = ""
                    }
                };
//                data = {
//                    "username": document.getElementById("username").value,
//                    "password": document.getElementById("password").value
//                }
//                req.open("POST", "http://localhost:8080/", true);
//                req.send(JSON.stringify(data));
                req.open("POST", "http://localhost:8080/" + document.getElementById("username").value + "/" + document.getElementById("password").value, true);
                req.send(null);
            }
        }

        function updateStats() {
            var req = new XMLHttpRequest();
            req.onreadystatechange = function() {
                if (req.readyState == 4 && req.status == 200) {
                    sessionStorage.setItem('username', document.getElementById("username").value);
                    window.location.href = "http://localhost:9000/profile";
                }
            };
            req.open("POST", "http://localhost:8080/stats/" + document.getElementById("username").value, true);
            req.send(null);
        }
    </script>
</head>

<body>
<div class="section"></div>
<main>
    <h5 class="indigo-text center">Login to Generic Social App</h5>
    <div class="section"></div>

    <div class="container center">
        <div class="z-depth-1 grey lighten-4 row" style="display: inline-block; padding: 32px 48px 0px 48px; border: 1px solid #EEE;">
            <div class='row'>
                <div id="message" class='col s12'>
                </div>
            </div>
            <form action="javascript:login()">
                <div class='row'>
                    <div class='input-field col s12'>
                        <input class='validate' type='text' name='username' id='username' minlength="2" required/>
                        <label for='username'>Enter your username</label>
                    </div>
                </div>

                <div class='row'>
                    <div class='input-field col s12'>
                        <input class='validate' type='password' name='password' id='password' minlength="2" required/>
                        <label for='password'>Enter your password</label>
                    </div>
                    <label style='float: right;'>
                        <a class='pink-text' href='#!'><b>Forgot Password?</b></a>
                    </label>
                </div>

                <br />
                <div class='row'>
                    <button type='submit' name='btn_login' class='col s12 btn btn-large waves-effect indigo'>Login</button>
                </div>
            </form>
        </div>
    </div>
    <section class="center">
        <a class='blue-text' href='register'><strong>Create Account</strong></a>
    </section>
</main>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.5/js/materialize.min.js"></script>
</body>

</html>