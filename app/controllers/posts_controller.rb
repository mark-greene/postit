class PostsController < ApplicationController
  before_action  :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]
  before_action :require_creator, only: [:edit, :update]

  def index
    @posts = Post.paginate(page: params[:page], per_page: 5, order: 'total_votes DESC')

    respond_to do |format|
      format.html
      format.xml { render xml: @posts }
      format.json { render json: @posts }
    end
  end

  def show
    @comment = Comment.new

    respond_to do |format|
      format.html
      format.xml { render xml: @post }
      format.json { render json: @post }
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params

    @post.creator = current_user

    if @post.save
      flash[:notice] = "Your post was successfully created"
      @post.save_total_votes
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update post_params
      flash[:notice] = "Your post was successfully updated"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def vote
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
     if @vote.valid?
        @post.save_total_votes
     end

    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "Your vote was counted"
        else
          flash[:error] = "You can only vote once"
        end
        redirect_to :back
      end
      format.js
    end

  end

private
  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find_by slug: params[:id]
  end

  def require_creator
    access_denied unless logged_in? and (current_user == @post.creator || current_user.admin?)
  end
end
