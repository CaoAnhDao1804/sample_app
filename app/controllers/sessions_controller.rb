class SessionsController < ApplicationController
  before_action :load_user, only: :create
  def new; end

  def create
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        params[:session][:remember_me] == Settings.session_controller.remember_me ? remember(@user) : forget(@user)
        redirect_back_or @user
      else
        message = t ".message1"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = t ".combination"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def load_user
    @user = User.find_by email: params[:session][:email].downcase
  end
end
