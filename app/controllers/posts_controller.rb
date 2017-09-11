class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :check_owner, only: [:edit, :update, :destroy]

  def new
  	@post = Post.new
  end

  def index
  	@posts = Post.search(params[:search])
  end

  def show
    @comments = @post.comments
  	@comment = @post.comments.new
  end

  def create
  	@post = current_user.posts.new(post_params)
  	if @post.save
  		flash[:success] = 'Post success'
  		redirect_to post_path(@post)
  	else
  		flash[:error] = @post.errors.full_messages.join
  		redirect_to new_post_path
  	end
  end

  def edit

  end

  def update
  	if @post.update(post_params)
  	  redirect_to posts_path
  	else
  	  render 'edit'
  	end
  end

  def destroy
  		
    @post.destroy
    redirect_to posts_path
  end

  def location
    @posts = Post.where(location: params[:location])
  end

  private

  	def post_params
  	  params.require(:post).permit(:image, :description, :location)
  	end

  	def set_post
  	  @post = Post.find(params[:id])
  	end

  	def check_owner
  	  unless current_user == @post.user
  	  	flash[:alert] = "That post doesn't belong to you"
  	  	redirect_to root_path
  	  end
  	end

end
