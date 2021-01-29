# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
    @post = Post.new
    @users = User.all.order(created_at: :desc)
    @events = Event.all.order(created_at: :desc)
    @coming_events = Event.coming_events
    @prev_events = Event.old_events
  end

  def new; end

  def create
    @post = current_user.posts.build(post_params)
    redirect_back fallback_location: root_path if @post.save
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
