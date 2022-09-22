class HomeController < ApplicationController
  def index
  @posts = Post.all
  respond_to do |format|
    format.html { render :index  }
    format.json { render :layout => false }
    format.js   { render :layout => false }
 end
  end
end
