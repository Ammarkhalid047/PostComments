class UserMailer < ApplicationMailer
    default form: 'muhammadahad6785@gmail.com'

    def user_registration_email( resource )
        @user = resource
        mail(to: @user.email , subject: 'welcome to our blog site')
    end
    
end
