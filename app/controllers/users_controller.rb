class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @trips = @user.trips
    if params[:trip].present?
      @trip = Trip.find(params[:trip])
    else
      @trip = Trip.last
    end
    @markers = []
    @user.trips.each do |trip|
      steps_list = []
      trip.steps.order(:date).each do |step|
        steps_list << {
          lat: step.latitude,
          lng: step.longitude,
          }
      end
      @markers << steps_list
    end

    @current_markers = []
    @trip.steps.order(:date).each do |step|
      @current_markers << {
        lat: step.latitude,
        lng: step.longitude,
        }
    end

    @photos = []
    @user.trips.each do |trip|
      steps_list = []
      trip.moments.each do |moment|
        steps_list << {
          lat: moment.latitude,
          lng: moment.longitude,
          photo_html: render_to_string(partial: "moments/photo", locals: { moment: moment })
          }
      end
      @photos << steps_list
    end
  end
end
