class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_filter :set_timezone
  around_action :set_timezone, if: :signed_in?

  protected

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  helper_method :current_user, :signed_in?

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.nil? ? nil : user.id
  end

  private

  def set_timezone(&action)
    Time.use_zone(current_user.time_zone, &action)
  end

  # def old_set_timezone
  #   tz = current_user ? current_user.time_zone : nil
  #   Time.zone = tz || ActiveSupport::TimeZone["London"]
  # end
  
end
