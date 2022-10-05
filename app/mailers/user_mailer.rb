class UserMailer < ApplicationMailer
    

    def user_registration_email( resource )
        @user = resource
        mail(to: @user.email , subject: 'welcome to our blog site')
    end

    def user_status(user)
        @user = user
        if @user.status == 'active'
        mail(to: @user.email , subject: 'Hurrah! Your account has been activated')
        elsif @user.status == 'inactive'
        mail(to: @user.email , subject: 'Aghh! Your account has been inactivated')
        end
    end
    
end
