class RegistrationsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user, only: [:index, :edit, :update, :destroy]

  def index
    @excursion = Excursion.find(params[:excursion_id])
    @registrations = Registration.where(excursion_id: params[:excursion_id])
    calculate_reserved
  end

  def show
    @registration = Registration.find(params[:id])
  end

  def new
    @excursion = Excursion.find(params[:excursion_id])
    if !@excursion.active?
      flash[:danger] = I18n.t('excursion_not_active')
      redirect_to root_url
    else
      @registration = Registration.new
    end

  end

  def edit
    @registration = Registration.find(params[:id])
  end

  def create
    @excursion = Excursion.find(params[:excursion_id])
    @registration = Registration.new(registration_params)
    @registration.excursion_id = @excursion.id
    @registrations = Registration.where(excursion_id: params[:excursion_id])

    if user_is_registered
      flash[:danger] = I18n.t('errors.already_registered')
      redirect_to root_url
    else
      if bus_has_available_spots
        perform_registration
      else
        flash[:danger] = I18n.t('errors.not_enough_spots')
        redirect_to root_url
      end
    end
  end

  def update
    @excursion = Excursion.find(params[:excursion_id])
    @registration = Registration.find(params[:id])
    if @registration.update(registration_params)
      flash[:success] = I18n.t('success.registration_updated')
      redirect_to excursions_path
    else
      render 'edit'
    end
  end

  def destroy
    @registration = Registration.find(params[:id])
    @registration.destroy

    redirect_to excursion_registrations_path
  end

  private
  def perform_registration
    if @registration.save
      flash[:success] = I18n.t('success.registration_correct').concat(@excursion.name)
      redirect_to root_url
    else
      flash[:danger] = I18n.t('errors.unable_to_register')
      render 'new'
    end
  end

  def bus_has_available_spots
    reservedSpots = 0
    @excursion.registrations.each do |registration|
      reservedSpots += registration.busSpots
    end
    reservedSpots += @registration.busSpots
    reservedSpots <= @excursion.busSpots
  end

  # Calculate reserved spots
  def calculate_reserved
    @bus = 0
    @lunch = 0
    @registrations.each do |i|
      @bus += i.busSpots
      @lunch += i.lunchSpots
    end
  end

  def registration_params
    params.require(:registration).permit(:name, :phoneNumber, :email, :busSpots, :lunchSpots, :excursion_id, :coi)
  end

  # Confirms the user has admin privileges.
  def admin_user
    unless admin_user?
      flash[:danger] = I18n.t('errors.unprivileged_user')
      redirect_to root_url
    end
  end

  #Confirms that user is logged in
  def logged_in_user
    unless logged_in?
      flash[:danger] = I18n.t('errors.login_first')
      redirect_to login_url
    end
  end

  def user_is_registered
    @registrations.any? { |registration| registration.email == current_user.email }
  end
end
