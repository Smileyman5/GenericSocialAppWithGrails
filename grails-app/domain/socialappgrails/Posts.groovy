package socialappgrails

class Posts {

    Users username
    String messageBody
    Long timeStamp = System.nanoTime()

    static constraints = {
        username nullable: false, blank: false
        messageBody blank: false
    }
}
