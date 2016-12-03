class StaticController < ApplicationController
  # We do not need to check if the user is logged in if they are on the static pages.
  skip_before_action :require_login

  def welcome
  end

  def about
  end
end
