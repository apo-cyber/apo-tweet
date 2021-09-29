class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :login_required

  private

    def current_user
      @current_user||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def login_required
      unless current_user
        flash[:notice] = "ログインが必要です"
        redirect_to login_path
      end
    end

    def require_current_user
      unless current_user.admin
        unless current_user.id==params[:id].to_i
          flash[:notice]="権限がありません。"
          redirect_to user_path(current_user)
        end
      end
    end

end
