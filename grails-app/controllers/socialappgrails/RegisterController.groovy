package socialappgrails

/**
 * Created By: Jonathan Baker
 */

class RegisterController {

    def index() {
        render(view: 'index.gsp')
    }

    def register() {
        String username = params.username
        String password = params.password
        String rePassword = params.repassword

        if (password != rePassword) {
            return render(status: 500, view: "index.gsp", model: ['message': 'Passwords do not match.'])
        }

        if (Users.findByUsername(username) != null) {
            return render(status: 500, view: "index.gsp", model: ['message': 'Username already exists. :/'])
        }

        createUser(username, password)
        session["username"] = username
        render(status: 200, view: "../profile/index.gsp")
    }

    def createUser(String username, String password) {
        println("Adding a new user: " + username + " " + password)
        Users user = Users.create()
        user.username = username
        user.password = password
        user.birthday = "03/16/1995"
        user.firstName = "Alex"
        user.lastName = "Man"
        user.gender = "Male"
//        user.login = 0
//        user.id = 4
//        user.version = 0
        user.save()
//        Users u = new Users(username: username, password: password).save()
    }

}
