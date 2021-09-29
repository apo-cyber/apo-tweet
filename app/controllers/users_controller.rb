class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_current_user, only: [:edit, :update, :destroy]
  skip_before_action :login_required, only:[:new, :create]


  def index
    @users=User.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @user=User.new
    @iconlabel='new'
  end

  def edit
    @iconlabel=nil
  end

  def create
    @user=User.new(user_params)
    @user.admin=false
    if @user.save
      session[:user_id]=@user.id
      redirect_to posts_path, notice: 'ユーザー登録が完了しました!'
    else
      flash[:alert]= 'Save error!'
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'ユーザー登録が完了しました!'
    else
      flash[:alert]= 'Save error!'
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: 'ユーザーを削除しました!'
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    end

    def set_user
      @user=User.find(params[:id])
    end

end
