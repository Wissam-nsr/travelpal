class MomentsController < ApplicationController
  def new
    @moment = Moment.new
  end

  def create
    if @trip = current_user.trips.last.present?
      @trip = current_user.trips.last
    else
      redirect_to user_path(current_user)
    end
    @moment = Moment.new(moment_params)
    @moment.trip = @trip
    @moment.date = Date.today
    results = Geocoder.search(@moment.location)
    @moment.latitude = results.first.coordinates[0]
    @moment.longitude = results.first.coordinates[1]
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
