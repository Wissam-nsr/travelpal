class UsersController < ApplicationController
  def show
    unless user_signed_in?
      redirect_to landing_path
    else
      @user = User.find(params[:id])
      @trips = @user.trips
      if params[:trip].present?
        @trip = Trip.find(params[:trip])
      else
        @trip = @user.trips.last
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
      unless @trips.empty?
        @trip.steps.order(:date).each do |step|
          @current_markers << {
            lat: step.latitude,
            lng: step.longitude,
            }
        end
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

  def update
    @user = current_user
    if request.remote_ip == "::1"
      # Eiffel tower coordinates to test
      @user.latitude = "48.8590453"
      @user.longitude = "2.2933084"
    else
      @user.latitude = request.location.latitude
      @user.longitude = request.location.longitude
    end
    @user.save
    redirect_to home_path
    flash[:message] = puts "data-ip: #{request.location.data["ip"]}, remote_ip: #{request.remote_ip}"
  end
end
