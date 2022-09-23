class PostMailer < ApplicationMailer
    default form: 'ammar047@localhost.com'

    def post_created(post)
        @post = post
        mail(to: @post.user.email, subject: 'Hurrah! Your post has been created')
    end
end
