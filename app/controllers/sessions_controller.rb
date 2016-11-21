class SessionsController < ApplicationController
  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    puts auth_hash
    puts auth_hash['info']
    
    # Find an authorization, or create a new authorization if one isn't found
    @authorization = Authorization.find_or_create_from_hash(auth_hash)

    if signed_in?
      if @authorization.user == current_user
        # User is signed in so they are trying to link an authorization with their account.
        # But we found the authorization and the user associated with it is the current user.
        # So the authorization is already associated with this user. So let's display an error message.
        redirect_to edit_user_url(current_user.id), notice: "Already linked that account!"
      elsif @authorization.user.nil?
        # The authorization is not associated with the current_user so lets associate the authorization
        @authorization.user = current_user
        @authorization.save
        redirect_to edit_user_url(current_user.id), notice: "Successfully linked that account!"
      else
        redirect_to edit_user_url(current_user.id), notice: "This #{@authorization.provider.capitalize} is already linked to an account."
      end
    else
      if @authorization.user.present?
        # The authorization we found had a user associated with it so let's just log them in here
        self.current_user = @authorization.user
        redirect_to user_path(current_user.nickname), notice: "Signed in!"
      else
        # No user associated with the authorization so we create a new one
        @user = User.create_from_hash(auth_hash)
        @user.nickname = @user.check_nickname
        @user.save

        self.current_user = @user
        @authorization.user = current_user
        @authorization.save
        
        if current_user.email
          UserMailer.welcome_email(current_user).deliver_later   
        end
        # redirect_to root_url, notice: "New account created!"
        redirect_to edit_user_path(current_user.nickname), notice: "New account created!"
      end
    end
  end

  def destroy
    # Use 'reset session' to completely destroy all session data
    reset_session
    self.current_user = nil
    redirect_to '/', notice: 'Logged out!'
  end
end
