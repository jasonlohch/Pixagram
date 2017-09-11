class CommentsController < ApplicationController

  def create
  	@post = Post.find(params[:post_id])
  	@comment = current_user.comments.new(comment_params)
  	@comment.post = @post

    if @comment.save
    	respond_to do |format|
    		format.html { redirect_to post_path(@post) }
    		format.js
    	end
    	#flash[:success] = "You have commented on the post"
    	#redirect_to @post
    else
    	flash[:alert] = "Something went wrong with your comment"
    	render root_path
    end
  end

  def destroy
  	@comment = Comment.find(params[:id])
    post = @comment.post
  	@comment.destroy
  	flash[:success] = "Your comment has been deleted"
  	redirect_to post_path(post)
  end

  private

  	def comment_params
 	  params.require(:comment).permit(:content)
  	end

end
