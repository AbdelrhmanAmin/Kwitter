class PostsController < ApplicationController
  def index
  @posts = Post.all.order(created_at: :desc)
  @post = Post.new
  @users = User.all
  end
  def new
  end
  def create
    @post = current_user.posts.build(post_params)

      if @post.save
        redirect_to root_path
      end
  end
  def post_params
    params.require(:post).permit(:content)
  end
end
