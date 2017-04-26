package socialappgrails

import grails.converters.JSON

class PostingController {

    def index() { }

    def post() {
        def msg = params['comment']
        Posts post = Posts.create()

        post.username = Users.findByUsername(session['username'].toString())
        post.messageBody = msg
        post.save()

        render view: "/profile/index"
    }

    def addCommentOrLike() {
        def msg = params['comment']
        def postId = params['postId'] as Long
        LikesAndComments comment = LikesAndComments.create()

        comment.username = Users.findByUsername(session['username'].toString())
        comment.comment = msg
        comment.liked = false
        comment.post = Posts.findById(postId)
        comment.save()
        render view: "/profile/index"
    }

    def getAllPostsByName() {
        def userPosts = Posts.findAllByUsername(Users.findByUsername(session['username'].toString()))
        def friends = Friends.findAllByFriend(Users.findByUsername(session['username'].toString()))
        def allPosts = []
        for (Friends friend: friends)
            allPosts.addAll(Posts.findAllByUsername(friend.username))
        allPosts.addAll(userPosts)
        allPosts = allPosts.sort{it.timeStamp}.reverse()
        def json = [:]
        def arr = []
        for (Posts post: allPosts)
        {
            def obj = [:]
//            def likes = []
            def comments = []
            obj['id'] = post.id
            obj['user'] = post.username.username
            obj['msg'] = post.messageBody
            obj['timestamp'] = post.timeStamp

            def likesAndComments = LikesAndComments.findAllByPost(post)
            for (LikesAndComments lacs: likesAndComments)
            {
                comments.add(['username':lacs.username.username, 'comment':lacs.comment])
//                likes.add(['username':lacs.username.username, 'liked':lacs.liked])
            }

            obj['comments'] = comments.reverse()
//            obj['likes'] = likes
            arr.add(obj)
        }
        json['posts'] = arr
        render json as JSON
    }
}
