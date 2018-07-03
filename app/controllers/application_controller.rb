class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #Module to manage sessions
  include SessionsHelper

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private
  def record_not_found
    redirect_to error404_url
  end
end
