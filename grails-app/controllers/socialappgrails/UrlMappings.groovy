package socialappgrails

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: "login") {action = [GET: "index", POST: "login"]}
        "/stats/$username"(controller: "login") {action = [POST: "updateStats"]}
        "/profile"(controller: "profile") {action = [GET: "index"]}
        "/profile/settings"(controller: "profile") {action = [GET: "settings"]}
        "/profile/friends"(controller: "profile") {action = [GET: "friends"]}
        "/profile/friends/$username"(controller: "profile") {action = [GET: "addFriend", PUT: "confirmFriend", DELETE: "declineFriend"]}
        "/restful/profile/$username"(controller: "profile") {action = [GET: "getJsonProfile"]}
        "/restful/recommend/$username"(controller: "profile") {action = [GET: "getJsonRecommendation"]}
        "/friends"(controller: "friends") {action = [POST: "addFriend", PUT: "acceptRequest", DELETE: "declineRequest"]}
        "/register/$username/$password/$repassword"(controller: "register") {action = [GET: "index", POST: "register"]}
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
