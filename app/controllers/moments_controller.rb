class MomentsController < ApplicationController
  def new
    @moment = Moment.new
  end

  def create
    @trip = Trip.find(params[:trip_id])
    @moment = Moment.new(moment_params)
    @moment.trip = @trip
    if @moment.save
      redirect_to user_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @moment.destroy
  end

private

  def moment_params
    params.require(:moment).permit(:description, :date, :location, :photo)
  end

end
