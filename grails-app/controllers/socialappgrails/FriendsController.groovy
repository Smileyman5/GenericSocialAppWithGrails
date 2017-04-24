package socialappgrails

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class FriendsController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Friends.list(params), model:[friendsCount: Friends.count()]
    }

    def show(Friends friends) {
        respond friends
    }

    def create() {
        respond new Friends(params)
    }

    @Transactional
    def save(Friends friends) {
        if (friends == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (friends.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond friends.errors, view:'create'
            return
        }

        friends.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'friends.label', default: 'Friends'), friends.id])
                redirect friends
            }
            '*' { respond friends, [status: CREATED] }
        }
    }

    def edit(Friends friends) {
        respond friends
    }

    @Transactional
    def update(Friends friends) {
        if (friends == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (friends.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond friends.errors, view:'edit'
            return
        }

        friends.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'friends.label', default: 'Friends'), friends.id])
                redirect friends
            }
            '*'{ respond friends, [status: OK] }
        }
    }

    @Transactional
    def delete(Friends friends) {

        if (friends == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        friends.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'friends.label', default: 'Friends'), friends.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'friends.label', default: 'Friends'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
