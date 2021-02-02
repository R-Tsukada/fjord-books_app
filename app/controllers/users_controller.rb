class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @users = User.find(params[:id])
  end

  def edit
    @users = User.find(params[:id])
  end

  def update
    users = User.find(params[:id])
    users.update!(users_params)
    redirect_to users_url, notice: "User information has been updated."
  end

  private

  def users_params
    params.require(:users).permit(:id, :email, :postal_code, :address, :description)
  end
end
