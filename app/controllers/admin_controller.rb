class AdminController < ApplicationController

    before_action :is_admin?
    before_action :get_all_users, only: [:index, :destroy, :show, :pending_approvals]
    before_action :find_user, only: [:destory, :edit, :update, :change_status]
    before_action :get_all_posts, only: [:show, :pending_approvals]
    before_action :find_post, only: [:approve]
    


    def index

        respond_to do |format|
            format.html { redirect_to root_path }
            format.json { head :no_content }
            format.js   { render :layout => false }
        end

    end

    def show
        
        respond_to do |format|
            format.html { redirect_to root_path }
            format.json { head :no_content }
            format.js   { render :layout => false }
        end

    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        respond_to do |format|
            format.html { redirect_to root_path }
            format.json { head :no_content }
            format.js   { render :layout => false }
        end
    end

    def edit
    end

    def pending_approvals

        respond_to do |format|
            format.html { redirect_to root_path }
            format.json { head :no_content }
            format.js   { render :layout => false }
        end

    end

    def update
        @user.update(user_params)
        redirect_to admin_index_path
    end

    def approve
        @post.update(status:'approved')
        redirect_to admin_path('approvals')
    end


    def reject
        @post.update(status:'rejected')
        redirect_to admin_path('approvals')
    end

    def change_status
        if @user.status == 'inactive'
        @user.update(status:'active')
        else
        @user.update(status:'inactive')
        end
        redirect_to admin_path('approvals')
    end

    private
    def is_admin?
        redirect_to root_path unless current_user.admin? 
    end

    def get_all_users
        @users = User.all
    end

    def get_all_posts
        @posts = Post.all
    end

    def find_user
        @user = User.find(params[:id])
    end

    def find_post
        @post = Post.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name, :age, :email, :image, :password)
    end

end
