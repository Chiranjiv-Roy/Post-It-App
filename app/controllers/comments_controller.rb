class CommentsController < ApplicationController

  before_action :require_user
  def create
  @post = Post.find(params[:post_id])
  @comment = @post.comments.build(params.require(:comment).permit(:body))
  @comment.creator = current_user
    if @comment.save
      @post.comments.map(&:creator).uniq.each do |thread_member|
      Notification.create(recipient: thread_member, actor: current_user, action: "commented on a post", notifiable: @comment)
      end
      flash[:notice] = "Your comment was added."
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    #binding.pry
    comment = Comment.find(params[:id])
    vote = Vote.create(voteable: comment, creator: current_user, vote: params[:vote])
    if vote.valid?
      if params[:vote]
        action = "upvoted your comment"
      else
        action = "downvoted your comment"
      end
      Notification.create(recipient: comment.creator, actor: current_user, action: action, notifiable: comment)
      flash[:notice] = "Your vote was counted successfully."
    else
      flash[:error] = "You can only vote on a comment once."
    end
    redirect_to :back
  end
end