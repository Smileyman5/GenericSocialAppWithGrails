package socialappgrails

import grails.converters.JSON
import org.grails.web.json.JSONObject

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
        println("URL: " + request.forwardURI)
        JSONObject jsonObject = request.JSON
        String username = jsonObject.get("username")
        String password = jsonObject.get("password")

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

    def login2() {
        println("URL2: " + request.forwardURI)
        String username = params.username
        String password = params.password
        println("Username: " + username)
        println("Password: " + password)
//        JSONObject jsonObject = request.JSON
//        String username = jsonObject.get("username")
//        String password = jsonObject.get("password")

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
