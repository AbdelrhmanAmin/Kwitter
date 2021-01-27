class PostsController < ApplicationController
  def index
  @posts = Post.all.order(created_at: :desc)
  @post = Post.new
  @users = User.all.order(created_at: :desc)
  end
  def new
  end
  def create
    @post = current_user.posts.build(post_params)
      if @post.save
         redirect_back fallback_location: root_path
        end
  end
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_back fallback_location: root_path
  end
  def post_params
    params.require(:post).permit(:content)
  end
end
