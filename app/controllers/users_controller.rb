class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update]
  before_action :admin_user, only: [:index, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    set_default_active_and_role(@user)
    if @user.save
      log_in @user
      flash[:success] = I18n.t('success.signup_correct')
      redirect_to root_url
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = I18n.t('success.updated_info')
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.update_attributes(change_active_attribute)
      flash[:success] = I18n.t('success.user_deactivated')
      redirect_to users_path
    else
      flash.now[:danger] = I18n.t('error.unable_to_deactivate')
      redirect_to @user
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :surname, :phoneNumber, :email, :password,
    :password_confirmation)
  end

  #Confirms that user is logged in
  def logged_in_user
    unless logged_in?
      flash[:danger] = I18n.t('errors.login_first')
      redirect_to login_url
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless (current_user?(@user) || admin_user?)
  end

  # Confirms the user has admin privileges.
  def admin_user
    unless admin_user?
      flash[:danger] = I18n.t('errors.unprivileged_user')
      redirect_to root_url
    end
  end

  #Set default properties (active user and not admin)
  def set_default_active_and_role(user)
    user.admin = false
    user.active = true
  end

  #Deactive an user
  def change_active_attribute
    user_hash = Hash.new()
    @user.attributes.each do |key, value|
      user_hash[key] = value
    end
    user_hash["active"] = !user_hash["active"]
    user_hash
  end

end
