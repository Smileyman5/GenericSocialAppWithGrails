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
        String rePassword = params.password

        if (!password.equals(rePassword)) {
            render(status: 500)
        }

        if (Users.findAllByUsernameAndPassword(username, password).isEmpty()) {
            render(status: 500)
        }

        createUser(username, password)
        render(status: 200)
    }

    def createUser(String username, String password) {
        Users user = new Users();
        user.username = username;
        user.password = password;
        user.save();
    }

}
