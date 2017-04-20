package socialappgrails

class LikesAndComments {

    Users username
    boolean liked = false
    String comment = ""
    Posts post

    static constraints = {
        username nullable: false
        post nullable: false
    }
}
