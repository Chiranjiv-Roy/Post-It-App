class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = User.first      #change this once authentication is complete

    if @post.save
      flash[:notice] = "Your Post was created."
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = "The Post was updated."
      redirect_to posts_path
    else
      render 'edit'
    end

  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :description, category_id: [])
  end
end
