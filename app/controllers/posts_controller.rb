class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    # @posts=Post.all.order(created_at: :desc)
    @q = Post.all.ransack(params[:q])
    @posts = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(3)
  end

  def show
    @like = Like.new
  end

  def new
    @post=Post.new
  end

  def edit
  end

  def create
    @post=current_user.posts.new(post_params)
    if @post.save
      redirect_to posts_path, notice: '投稿を作成しました!'
    else
      flash[:alert]= 'Save error!'
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: '投稿を編集しました!'
    else
      flash[:alert]= 'Save error!'
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: '投稿を削除しました!'
  end

  private
    def post_params
      params.require(:post).permit(:title, :content, :image)
    end

    def set_post
      @post=Post.find(params[:id])
    end

end
