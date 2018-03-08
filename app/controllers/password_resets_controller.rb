class PasswordResetsController < ApplicationController
  before_action :load_user, only: %i(edit update)
  before_action :valid_user, only: %i(edit update)
  before_action :check_expiration, only: %i(edit update)

  def new; end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add :password, t(".not_empty")
      render :edit
    elsif @user.update_attributes user_params
      log_in @user
      flash[:success] = t(".reset_password")
      redirect_to @user
    else
      render :edit
    end
  end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t ".email_sent"
      redirect_to root_url
    else
      flash.now[:danger] = t ".mail_not_found"
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit :password, :password_confirmation
    end

    def load_user
      @user = User.find_by email: params[:email]
      @user || render(file: "public/404.html", status: 404, layout: true)
    end

    def valid_user
      redirect_to root_url unless @user && @user.activated? && @user.authenticated?(:reset, params[:id])
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = t ".expired_password"
        redirect_to new_password_reset_url
      end
    end
end
