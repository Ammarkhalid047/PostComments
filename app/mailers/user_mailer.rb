class UserMailer < ApplicationMailer
    

    def user_registration_email( resource )
        @user = resource
        byebug
        mail(to: @user.email , subject: 'welcome to our blog site')
    end
    
end
