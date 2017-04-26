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
    background: #fff;
}

main {
    flex: 1 0 auto;
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
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.5/js/materialize.min.js"></script>
</head>
<body>
<div class="section"></div>
    <h3 class="indigo-text center">Register Account</h3>
    <div class="section"></div>

    <div class="container center">
        <div class="z-depth-1 grey lighten-4 row" style="display: inline-block; padding: 32px 48px 0px 48px; border: 1px solid #EEE;">
            <g:form action="register" method="post">
                <div class='row'>
                    <div id="message" class='col s12 red-text'>
                        ${message ?: ""}
                    </div>
                </div>

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
                </div>

                <div class='row'>
                    <div class='input-field col s12'>
                        <input class='validate' type='password' name='repassword' id='repassword' minlength="2" required/>
                        <label for='repassword'>Re-enter your password</label>
                    </div>
                </div>

                <br />
                <div class='row'>
                    <button type='submit' name='btn_login' class='col s12 btn btn-large waves-effect indigo'>Register</button>
                </div>
            </g:form>
        </div>
    </div>
    <section class="center">
        <a class='blue-text' href="login"><strong>Login</strong></a>
    </section>
</body>
</html>