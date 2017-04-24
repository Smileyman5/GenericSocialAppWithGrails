package socialappgrails

import grails.converters.JSON
/**
 * Created by: Jonathan Baker
 */
class LoginController {

    //accessed on a get request
    //displays login page
    def index() {
        session.invalidate()
        // create a new session
        request.getSession(true)
        render (view: 'login.gsp')
    }

    //accessed on a post request
    //accepts a username and password in JSON
    //in JSON, returns login failed if result['failed'] = true
    //in JSON, returns login succeeds if result['loggedin'] = true
    def loginOld() {
        String username = request.JSON["username"]
        String password = request.JSON["password"]

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

    def login() {
        String username = params.get("username")
        String password = params.get("password")

        if (checkLogin(username, password)) {
            updateStats(username)
            session["username"] = username
            render(status: 200, view: '../profile/index')
        }
        else {
            render(status: 400, view: 'login', model: ['message': 'Username/Password is incorrect'])
        }
    }

    def updateStats(String username) {
        def user = Users.findByUsername(username)
        if (user != null)
        {
            user.login += 1
            user.save(flush: true)

            // render with status code
            return render(status: 200)
        }

        // render with status code
        render(status: 404, text: username + ' not found.')
    }

    //private method that checks user's login in database
    def checkLogin(String username, String password) {
        return Users.findByUsernameAndPassword(username, password) != null
    }

}
