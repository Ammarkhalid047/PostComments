class UserMailer < ApplicationMailer
    

    def user_registration_email(@user)
        mail(to: @user.email , subject: 'welcome to our blog site')
    end
    
end
