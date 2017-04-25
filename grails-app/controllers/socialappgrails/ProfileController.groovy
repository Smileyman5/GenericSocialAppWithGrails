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
        if (defriending != null)
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

    def deleteFriend() {
        def username = session['username'].toString()
        def friend = params['username'].toString()

        def friendship = Friends.findByUsernameAndFriendAndStatus(Users.findByUsername(username), Users.findByUsername(friend), RequestStatus.findByStatus("Confirmed"))
        friendship.delete(flush : true)
        friendship = Friends.findByUsernameAndFriendAndStatus(Users.findByUsername(username), Users.findByUsername(friend), RequestStatus.findByStatus("Confirmed"))
        friendship.delete(flush : true)

        render(view: "friends.gsp")
    }

    def deleteFriendRequest() {
        def username = session['username'].toString()
        def friend = params['username'].toString()

        def friendship = Friends.findByUsernameAndFriendAndStatus(Users.findByUsername(username), Users.findByUsername(friend), RequestStatus.findByStatus("Pending"))
        friendship.delete(flush : true)

        render(view: "friends.gsp")
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
        List<String> friends = Friends.findAllByUsernameAndStatus(Users.findByUsername(user), RequestStatus.findByStatus("Confirmed")).friend.username
        friends.toArray() as JSONArray
    }

    def getPendingJson(String user) {
        List<String> friends = Friends.findAllByUsernameAndStatus(Users.findByUsername(user), RequestStatus.findByStatus("Pending")).friend.username
        friends.toArray() as JSONArray
    }

    def getRequestedJson(String user) {
        List<String> friends = Friends.findAllByFriendAndStatus(Users.findByUsername(user), RequestStatus.findByStatus("Pending")).username.username
        friends.toArray() as JSONArray
    }

    def getJsonRecommendation() {
        def jsonArray = []
        def name = params['username'].toString()
        if (name != "") {
            def friends = Friends.findAllByUsername(Users.findByUsername(name))
            for (Friends friend: friends)
            {
                println("User's Friend: " + friends.friend.username)
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
                    if (users.username != name && Friends.findByUsernameAndFriend(Users.findByUsername(name), users) == null
                            && Friends.findByUsernameAndFriend(users, Users.findByUsername(name)) == null)
                        jsonArray.add(users.username)
            }
        }
        render jsonArray as JSON
    }

    def search() {
        if (session['username'] == null)
            return render(view: '../login/login.gsp')

        def jsonArray = []
        def username = session['username'].toString()
        def searchTerm = params['username'].toString()

        List<String> searchedUsers = Users.findAllByUsernameLikeAndUsernameNotEqual(searchTerm + "_%", username).username
        List<String> userFriends1 = Friends.findAllByUsername(Users.findByUsername(username)).friend.username
        List<String> userFriends2 = Friends.findAllByFriend(Users.findByUsername(username)).username.username

        for (String u: searchedUsers) {
            //removing any of the current user's friends from list of searched users
            if (!userFriends1.contains(u) && !userFriends2.contains(u)) {
                jsonArray.add(u)
            }
        }

        render jsonArray as JSON
    }
}
