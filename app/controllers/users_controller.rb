class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @trips = @user.trips
  end
end
