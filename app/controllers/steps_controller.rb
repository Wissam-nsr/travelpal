class StepsController < ApplicationController
before_action :set_step, only: [:edit, :update, :destroy]


  def index
    @trip = Trip.find(params[:trip_id])
    @steps = @trip.steps
  end

  def new
    @step = Step.new
  end

  def create
    @trip = Trip.find(params[:trip_id])
    @step = Step.new(step_params)
    @step.trip = @trip
    if @step.save
      redirect_to user_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @step.update(step_params)
      redirect_to user_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @step.destroy
  end

  private

  def step_params
    params.require(:step).require(:name, :description, :date, :location)
  end

  def set_step
    @step = Step.find(params[:step_id])
  end

end
