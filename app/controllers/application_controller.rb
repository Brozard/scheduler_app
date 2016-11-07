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

  # Double NOT to test whether or not there is a current user.
  # If there is, this will return 'true.' Otherwise, it returns 'false.'
  def signed_in?
    !!current_user
  end

  # Single NOT to test whether or not there is a value for the current user's nickname.
  # If there is, it will return 'false.' Otherwise, it will return 'true.'
  def missing_nickname?
    !current_user.nickname
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
