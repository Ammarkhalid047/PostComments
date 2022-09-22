class CommentsController < ApplicationController 


  load_and_authorize_resource

    def index
      @post = Post.find(params[:post_id])
        @comment = Comment.new(user_id: current_user.id, post_id: params[:post_id], description: params[:description], rating: params[:rating])
        if @post.user != current_user 
        @comment.save
        end
        respond_to do |format|
            format.html { redirect_to post_path(@post) }
            format.json { head :no_content }
            format.js   { render :layout => false }
         end
    end
    def create
        @post = Post.find(params[:post_id])
        @comment = Comment.new(comment_params.merge(user_id: current_user.id, post_id: params[:post_id], rating: params[:rating]))
        if @post.user != current_user 
        @comment.save
        end
        respond_to do |format|
            format.html { redirect_to post_path(@post) }
            format.json { head :no_content }
            format.js   { render :layout => false }
         end
      end
      
    def destroy
        @post = Post.find(params[:post_id])
        @comment = Comment.find(params[:id])
        @comment.delete
        respond_to do |format|
            format.html { redirect_to post_path(@post), status: :see_other }
            format.json { head :no_content }
            format.js   { render :layout => false }
         end
      end
      private
        def comment_params
          params.require(:comment).permit(:description, :rating)
        end
end
