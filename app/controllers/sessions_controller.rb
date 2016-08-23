class SessionsController < ApplicationController
  def new
  end

  def create
    # Create a new session by finding the User record that matches the email entered
    user = User.find_by_email(params[:email])
    # If the User record exists and the password entered is correct...
    if user && user.authenticate(params[:password])
      # ...set the session user to that User's ID, set an expiration timer to the session, and redirect to root.
      session[:user_id] = user.id
      session[:expires_at] = Time.current + 15.minutes
      redirect_to '/'
    # ...otherwise, re-render this page.
    else
      render :new
    end
  end

  def destroy
    # Use 'reset session' to completely destroy all session data
    reset_session
    redirect_to '/', notice: 'Logged out!'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
