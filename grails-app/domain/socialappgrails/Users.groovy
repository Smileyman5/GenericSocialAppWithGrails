package socialappgrails

class Users {
    String username
    String password
    String birthday
    String firstName
    String lastName
    String gender
    Long login = 0

    static constraints = {
        username size: 2..64, blank: false, unique: true
        password size: 2..64, blank: false, password: true
        birthday date: true
        gender validator: {val ->
            return val == "Male" || val == "Female"
        }
    }
}
