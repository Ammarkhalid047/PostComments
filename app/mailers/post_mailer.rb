class PostMailer < ApplicationMailer
   

    def post_created(post)
        @post = post
        mail(to: @post.user.email, subject: 'Hurrah! Your post has been created')
    end

    def post_approved(post)
        @post = post
        mail(to: @post.user.email, subject: 'Hurrah! Your post has been approved')
    end
end
