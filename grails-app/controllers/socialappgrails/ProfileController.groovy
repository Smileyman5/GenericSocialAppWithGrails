package socialappgrails

import grails.converters.JSON
import org.grails.web.json.JSONArray

class ProfileController {

    def index() {
        if (session['username'] == null)
            return render(view: '../login/login.gsp')
        render(view: 'index.gsp')
    }

    def settings() {
        if (session['username'] == null)
            return render(view: '../login/login.gsp')
        render(view: 'settings.gsp')
    }

    def friends() {
        if (session['username'] == null)
            return render(view: '../login/login.gsp')
        render(view: 'friends.gsp')
    }

    def post() {
        if (session['username'] == null)
            return render(view: '../login/login.gsp')
        render(view: 'index.gsp')
    }

    def addFriend() {
        if (session['username'] == null)
            return render(view: '../login/login.gsp')
        def newFriend = params['username'].toString()
        def friending = Friends.create()
        friending.username = Users.findByUsername(session['username'].toString())
        friending.friend = Users.findByUsername(newFriend)
        friending.status = RequestStatus.findByStatus("Pending")
        friending.save()
        render(view: 'friends.gsp')
    }

    def removeFriend() {
        if (session['username'] == null)
            return render(view: '../login/login.gsp')
        def notFriend = params['username'].toString()
        def defriending = Friends.findByUsernameAndFriend(Users.findByUsername(notFriend), Users.findByUsername(session['username'].toString()))
        def defriending2 = Friends.findByUsernameAndFriend(Users.findByUsername(session['username'].toString()), Users.findByUsername(notFriend))
        if (defriending2 != null)
            defriending2.delete(flush: true)
        defriending.delete(flush: true)
        render(view: "friends.gsp")
    }

    def confirmFriend() {
        if (session['username'] == null)
            return render(view: '../login/login.gsp')
        def newFriend = params['username'].toString()
        def friending = Friends.findByUsernameAndFriend(Users.findByUsername(newFriend), Users.findByUsername(session['username'].toString()))
        friending.status = RequestStatus.findByStatus("Confirmed")

        def friending2 = Friends.create()
        friending2.username = friending.friend
        friending2.friend = friending.username
        friending2.status = RequestStatus.findByStatus("Confirmed")

        friending.save(flush: true)
        friending2.save(flush: true)
        render(view: "friends.gsp")
    }

    def declineFriend() {
        removeFriend()
    }

    def getJsonProfile() {
        def username = params['username'].toString()
        //collect all confirmed friends
        def conFriends = getConfirmedJson(username)

        //collect all pending friend requests made by user
        def penFriends = getPendingJson(username)

        //collect all friend requests from other users that are requesting user
        def reqFriends = getRequestedJson(username)

        def list = [:]
        list["confirmed"] = conFriends
        list["requested"] = penFriends
        list["pending"] = reqFriends
        render list as JSON
    }

    def getConfirmedJson(String user) {
        def list = []
        List<Friends> friends = Friends.findAllByUsername(Users.findByUsername(user))
        for (Friends friend: friends) {
            if (friend.status.status == "Confirmed" && !list.contains(friend.friend.username))
                list.add(friend.friend.username)
        }
        return list as JSONArray
    }

    def getPendingJson(String user) {
        def list = []
        List<Friends> friends = Friends.findAllByUsername(Users.findByUsername(user))
        for (Friends friend: friends) {
            if (friend.status.status == "Pending" && !list.contains(friend.friend.username))
                list.add(friend.friend.username)
        }
        return list as JSONArray
    }

    def getRequestedJson(String user) {
        def list = []
        List<Friends> friends = Friends.findAllByFriend(Users.findByUsername(user))
        for (Friends friend: friends) {
            if (friend.status.status == "Pending" && !list.contains(friend.username.username))
                list.add(friend.username.username)
        }
        return list as JSONArray
    }

    def getJsonRecommendation() {
        def jsonArray = []
        def name = params['username'].toString()
        if (name != "") {
            def friends = Friends.findAllByUsername(Users.findByUsername(name))
            for (Friends friend: friends)
            {
                def recs = Friends.findAllByUsername(friend.username)
                for (Friends recFriend: recs)
                {
                    if (recFriend.username.username != name && !jsonArray.contains(recFriend.username.username))
                        jsonArray.add(recFriend.username.username)
                }
            }
            if (jsonArray.size() == 0)
            {
                def allUsers = Users.findAll()
                for (Users users: allUsers)
                    if (users.username != name && Friends.findByUsernameAndFriend(Users.findByUsername(name), users) == null)
                        jsonArray.add(users.username)
            }
        }
        render jsonArray as JSON
    }

    def updateUser() {
        def user = Users.findByUsername(session['username'].toString())
        if (params['Users.password'].toString() != "")
            user.password = params['Users.password'].toString()
        user.firstName = params['Users.firstName'].toString()
        user.lastName = params['Users.lastName'].toString()
        user.birthday = params['Users.birthday'].toString()
        user.gender = params['Users.gender'].toString()
        user.save(flush: true)

        if(!user.validate())
            render view: "settings", model: ['message': "Failed to update!", 'color': "red"]
        else
            render view: "settings", model: ['message': "Updated!", 'color': "green"]
    }
}
