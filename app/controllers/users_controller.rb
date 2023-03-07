class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @trips = @user.trips
    @moments = @user.moments
    @steps = @user.steps
  end
end
