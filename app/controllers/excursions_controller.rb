class ExcursionsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def index
    @excursions = Excursion.all
  end

  def show
    @excursion = Excursion.find(params[:id])
  end

  def new
    @excursion = Excursion.new
  end

  def edit
    @excursion = Excursion.find(params[:id])
  end

  def create
    @excursion = Excursion.new(excursion_params)

    if @excursion.save
      redirect_to @excursion
    else
      render 'new'
    end
  end

  def update
    @excursion = Excursion.find(params[:id])
    if @excursion.update(excursion_params)
      redirect_to @excursion
    else
      render 'edit'
    end
  end

  def destroy
    @excursion = Excursion.find(params[:id])
    @excursion.destroy

    redirect_to excursions_path
  end

  def download
    @excursion = Excursion.find(params[:id])
    respond_to do |format|
      format.html
      format.csv { send_data @excursion.to_csv , filename: "registrations-#{@excursion.name}.csv"}
    end
  end


  private
  def excursion_params
    params.require(:excursion).permit(:name, :busSpots, :lunchSpots, :active)
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
end
