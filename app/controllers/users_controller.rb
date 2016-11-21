class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # def new
  #   @user = User.new
  # end

  def edit
    # if missing_nickname?
    #   if current_user.authorizations.last.nickname || current_user.authorizations.last.username
    #     current_user.nickname = current_user.authorizations.last.nickname.downcase || current_user.authorizations.last.username.downcase
    #   end
    # end
  end

  def show
    @meetings = Meeting.where(user_id: current_user.id)
  end

  # def create
  #   @user = User.new(user_params)

  #   respond_to do |format|
  #     if @user.save
  #       format.html { redirect_to @user, notice: 'User was successfully created.' }
  #       format.json { render :show, status: :created, location: @user }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path(current_user.nickname), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      # @user = User.find_by(nickname: params[:nickname]) || User.find(params[:id])
      @user = User.find_by(nickname: current_user.nickname) || User.find(current_user.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :location, :time_zone, :nickname)
    end
end
