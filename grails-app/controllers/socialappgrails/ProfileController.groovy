package socialappgrails

class ProfileController {

    def index() { render(view: 'index.gsp') }

    def settings() { render(view: 'settings.gsp') }

    def friends() { render(view: 'friends.gsp') }
}
