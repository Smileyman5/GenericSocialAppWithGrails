package socialappgrails

import grails.converters.JSON

/**
 * Created by: Jonathan Baker
 */

class LoginController {

    //accessed on a get request
    //displays login page
    def index() {
        render (view: 'login.gsp')
    }

    //accessed on a post request
    //accepts a username and password in JSON
    //in JSON, returns login failed if result['failed'] = true
    //in JSON, returns login succeeds if result['loggedin'] = true
    def login() {
        String username = params.username
        String password = params.password
//        println("Username: " + username)
//        println("Password: " + password)

        def result = [:]
        result['failed'] = false
        result['loggedin'] = false

        if (checkLogin(username, password)) {
            result['loggedin'] = true
        }
        else {
            result['failed'] = true
        }

        render result as JSON
    }

    def checkLogin(String username, String password) {
        return false
    }

}
