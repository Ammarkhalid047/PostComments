class PostsController < ApplicationController

  before_action :fetch_posts, only: [:index, :create, :new, :destroy]

  before_action :find_post, only: [:show, :edit, :update, :destory]

  load_and_authorize_resource

  
  
  def index
  #   respond_to do |format|
  #     format.html { redirect_to root_path }
  #     format.json { head :no_content }
  #     format.js   { render :layout => false }
  #  end
  end
  
  def create
    @post = current_user.post.new(post_params)
    if @post.save
      PostMailer.post_created(@post).deliver_now
    end
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
      format.js   { render :layout => false }
   end
  end
  
  def show
  end

  def new
  end

  def edit
  end

  def update
    @post.update(post_params)
    # authorize! :update, @post
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
      format.js   { render :layout => false }
   end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
      format.js   { render :layout => false }
   end
  end

private
  
  def post_params
    params.require(:post).permit(:title, :description, {images: []})
  end

  def fetch_posts
    @posts = Post.all
  end

  def find_post
    @post = Post.find(params[:id])
  end

end
