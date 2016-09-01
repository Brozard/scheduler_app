class UserMailer < ApplicationMailer
  default from: 'omnischedulerapp@gmail.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://eatgamecode.com'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
