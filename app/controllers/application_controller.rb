class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_filter :set_timezone
  around_action :set_timezone, if: :signed_in?

  before_action :require_login

  # Used to extract a datetime object from params.
  # This is useful for receiving datetime_select attributes out of any ActiveModel.
  def parse_datetime_params(params, label, utc_or_local = :local)
    begin
      year   = params[(label.to_s + '(1i)').to_sym].to_i
      month  = params[(label.to_s + '(2i)').to_sym].to_i
      mday   = params[(label.to_s + '(3i)').to_sym].to_i
      hour   = (params[(label.to_s + '(4i)').to_sym] || 0).to_i
      minute = (params[(label.to_s + '(5i)').to_sym] || 0).to_i
      second = (params[(label.to_s + '(6i)').to_sym] || 0).to_i

      return DateTime.civil_from_format(utc_or_local,year,month,mday,hour,minute,second)
    # rescue => error
    #   return nil
    end
  end

  protected

    # Method to return the current user, either by instance variable or by looking up User record that matches session[:user_id].
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

    helper_method :current_user, :signed_in?, :missing_nickname?

    # Method to set the current user
    def current_user=(user)
      @current_user = user
      session[:user_id] = user.nil? ? nil : user.id
    end

  private

    # All time values are stored in the database as they are in UTC.
    # This method will change what timezone the user views these times in based on their timezone.
    def set_timezone(&action)
      Time.use_zone(current_user.time_zone, &action)
    end

    # Prior to loading a page, this function will check if the enduser is logged in as a User.
    # If they are not, it will redirect the to the Sign In page and require them to log in as a User.
    def require_login
      unless signed_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to signin_url # halts request cycle
      end
    end
end
