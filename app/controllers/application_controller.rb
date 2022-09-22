class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    skip_before_action :verify_authenticity_token 



    protected
        
        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image, :age, :email, :password])
            devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :image, :age, :email, :password])
        end
end