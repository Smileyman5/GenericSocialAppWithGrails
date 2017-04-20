package socialappgrails

class Friends {

    Users username
    Users friend
    RequestStatus status

    static constraints = {
        username nullable: false, blank: false
        friend nullable: false, blank: false
        status nullable: false
    }
}
