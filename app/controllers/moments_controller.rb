class MomentsController < ApplicationController
  before_action :set_moment, only: [:edit, :update, :destroy]

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

  def edit
  end

  def update
    if @moment.update(moment_params)
      redirect_to user_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @moment.destroy
  end

private

  def moment_params
    params.require(:moment).require(:description, :date, :location)
  end

  def set_moment
    @moment = Moment.find(params[:moment_id])
  end

end
