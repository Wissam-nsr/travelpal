class MomentsController < ApplicationController
  def new
    @moment = Moment.new
    @moment.trip = current_user.trips.last
  end

  def create
    if current_user.trips.empty?
      redirect_to user_path(user)
    else
      @trip = current_user.trips.last
    end
    @moment = Moment.new(moment_params)
    @moment.trip = @trip
    @moment.date = Date.today
    if @moment.location == "1"
      @moment.latitude = Geocoder.search(request.remote_ip).first.latitude
      @moment.longitude = Geocoder.search(request.remote_ip).first.longitude
    else
      results = Geocoder.search(@moment.location)
      @moment.latitude = results.first.coordinates[0]
      @moment.longitude = results.first.coordinates[1]
    end
    if @moment.save
      redirect_to user_path(current_user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @moment.destroy
  end

private

  def moment_params
    params.require(:moment).permit(:description, :location, :photo)
  end

end
