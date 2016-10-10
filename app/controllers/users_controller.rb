class UsersController < ApplicationController
  def new
  end

  def edit
  end

  def show
    @meetings = Meeting.where(user_id: current_user.id)
  end

  def create
  end

  def delete
  end
end
