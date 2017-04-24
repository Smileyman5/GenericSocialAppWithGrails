package socialappgrails

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PostsController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Posts.list(params), model:[postsCount: Posts.count()]
    }

    def show(Posts posts) {
        respond posts
    }

    def create() {
        respond new Posts(params)
    }

    @Transactional
    def save(Posts posts) {
        if (posts == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (posts.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond posts.errors, view:'create'
            return
        }

        posts.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'posts.label', default: 'Posts'), posts.id])
                redirect posts
            }
            '*' { respond posts, [status: CREATED] }
        }
    }

    def edit(Posts posts) {
        respond posts
    }

    @Transactional
    def update(Posts posts) {
        if (posts == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (posts.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond posts.errors, view:'edit'
            return
        }

        posts.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'posts.label', default: 'Posts'), posts.id])
                redirect posts
            }
            '*'{ respond posts, [status: OK] }
        }
    }

    @Transactional
    def delete(Posts posts) {

        if (posts == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        posts.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'posts.label', default: 'Posts'), posts.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'posts.label', default: 'Posts'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
