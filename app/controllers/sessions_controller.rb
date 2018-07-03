class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    check_login_credentials(user)
  end

  def destroy
    log_out
    flash[:success] = I18n.t('success.logged_out')
    redirect_to root_path
  end

  private

  def check_login_credentials(user)
    if user && user.authenticate(params[:session][:password]) && user.active?
      log_in user
      redirect_to root_url
    elsif user && !user.active?
      flash.now[:danger] = I18n.t('errors.deactivated_account')
      render 'new'
    elsif user && !user.authenticate(params[:session][:password])
      flash.now[:danger] = I18n.t('errors.wrong_credentials')
      render 'new'
    else
      flash.now[:danger] = I18n.t('errors.bad_email')
      render 'new'
    end
  end
end
