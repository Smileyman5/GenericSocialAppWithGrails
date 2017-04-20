package socialappgrails

class RequestStatus {

    String status

    static constraints = {
        status validator: {val, obj ->
            return val == "Pending" || val == "Confirmed"
        }
    }
}
