class CommentsController < ApplicationController

  before_action :require_user
  def create
  @post = Post.find(params[:post_id])
  @comment = @post.comments.build(params.require(:comment).permit(:body))
  @comment.creator = current_user
    if @comment.save
      (current_user.followees(User).uniq - [current_user] + [@post.creator]).uniq.each do |followee|
        Notification.new(recipient: followee, actor:current_user, action: "commented on a post", notifiable: @comment)
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
      Notification.new(recipient: comment.creator, actor:current_user, action: action, notifiable: vote)
      flash[:notice] = "Your vote was counted successfully."
    else
      flash[:error] = "You can only vote on a comment once."
    end
    redirect_to :back
  end
end