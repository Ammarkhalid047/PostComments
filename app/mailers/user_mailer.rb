class UserMailer < ApplicationMailer
    

    def user_registration_email( resource )
        @user = resource
        mail(to: @user.email , subject: 'welcome to our blog site')
    end

    def user_activated(user)
        @user = user
        mail(to: @user.email , subject: 'Hurrah! Your account has been activated')
    end

    def user_inactivated(user)
        @user = user
        mail(to: @user.email , subject: 'Aghh! Your account has been inactivated')
    end
    
end
