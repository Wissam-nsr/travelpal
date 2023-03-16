class UsersController < ApplicationController
  def show
    unless user_signed_in?
      redirect_to landing_path
    else
      @user = User.includes(:trips).find(params[:id])
      @trips = @user.trips.order(:id).reverse_order
      @params = params[:trip]
      if params[:trip].present?
        @trip = Trip.includes(:moments, :steps).find(@params)
      else
        @trip = @user.trips.last
      end
      @markers = []
      @user.trips.each do |trip|
        steps_list = []
        trip.steps.order(:date).each do |step|
          steps_list << {
            lat: step.latitude,
            lng: step.longitude
          }
        end
        @markers << steps_list
      end

      @current_markers = []
      unless @trips.empty?
        @trip.steps.order(:date).each do |step|
          @current_markers << {
            lat: step.latitude,
            lng: step.longitude
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
    ip = request.remote_ip
    if ip == "::1"
      latitude = "48.8584"
      longitude = "2.2945"
    else
      latitude = Geocoder.search(ip).first.latitude
      longitude = Geocoder.search(ip).first.longitude
    end
    @user.update!(latitude: latitude, longitude: longitude)
    redirect_to home_path
  end
end
