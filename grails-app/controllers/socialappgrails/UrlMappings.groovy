package socialappgrails

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: "login") {action = [GET:" index"]}
        "/$username/$password"(controller: "login") {action = [POST: 'login']}
        "/stats/$username"(controller: "stats") {action = [POST: "updateStats"]}
        "/profile"(controller: "profile") {action = {GET: "index"}}
        "/restful/profile/$username/$name"(controller: "profile") {action = {GET: "getProfile"}}
        "/friends"(controller: "friends") {action = [POST: "addFriend", PUT: "acceptRequest", DELETE: "declineRequest"]}
        "/register/$username/$password/$repassword"(controller: "register") {action = [GET: "index", POST: "register"]}
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
