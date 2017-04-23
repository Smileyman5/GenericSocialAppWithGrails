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
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.5/js/materialize.min.js"></script>
}
</head>
<body>
<div class="section"></div>
    <h3 class="indigo-text center">Register Account</h3>
    <div class="section"></div>

    <div class="container center">
        <div class="z-depth-1 grey lighten-4 row" style="display: inline-block; padding: 32px 48px 0px 48px; border: 1px solid #EEE;">
            @form(action=routes.RegisterController.register()) {
            @if(message != ""){
            <p style='color: red'>@message</p>
            }

            <div class="row">
                            <div class='input-field col s12'>
                @inputText(userForm("Username"))
            </div>
            </div>
            <div class="row">
                <div class='input-field col s12'>
                            @inputPassword(userForm("Password"))
                </div>
            </div>
            <div class="row">
                <div class='input-field col s12'>
                            @inputPassword(userForm("RePassword"), '_label -> "Retype Password")
                </div>
            </div>
            <div class='row'>
                <button type='submit' name='btn_login' class='col s12 btn btn-large waves-effect indigo'>Register</button>
            </div>
                }
        </div>
    </div>
    <section class="center">
        <a class='blue-text' href=""><strong>Login</strong></a>
    </section>
    <p>Already have friends here? Search <a href="@routes.SearchController.displayPage">here</a>.</p>
</body>
</html>