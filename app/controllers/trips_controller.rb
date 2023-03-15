class TripsController < ApplicationController
  before_action :set_trip, only: [:update, :destroy]

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user
    if @trip.save
      redirect_to user_path(current_user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @trip.update(trip_params)
      redirect_to user_path
    else
      render "users/show", status: :unprocessable_entity
    end
  end

  def destroy
    @trip.destroy
  end

  private

  def trip_params
    params.require(:trip).permit(:name, :description, :photo)
  end

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

end
