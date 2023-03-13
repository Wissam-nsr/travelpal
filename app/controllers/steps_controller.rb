require "json"
require "open-uri"

class StepsController < ApplicationController
before_action :set_step, only: [:edit, :update, :destroy]


  def index
    @trip = Trip.find(params[:trip_id])
    @steps = @trip.steps
  end

  def new
    if current_user.trips.any?
      @step = Step.new
    else
      render :new, status: :unprocessable_entity
  end

  def create
    if @trip = current_user.trips.last.present?
      @trip = current_user.trips.last
    else
      redirect_to user_path(current_user)
    end
    @step = Step.new(step_params)
    @step.trip = @trip
    @step.date = Date.today
    if @step.save
      redirect_to user_path(current_user)
    else
      flash.now[:notice] = 'You need to create a trip'
      redirect_to user_path
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
    params.require(:step).permit(:name, :description, :location)
  end

  def set_step
    @step = Step.find(params[:step_id])
  end

  def set_route
    trip = step.trip
    steps = trip.steps.order(:date)
    index = steps.index(step)
    if index == 0
      step.route = "#{step.latitude}, #{step.longitude}"
    else
      start_point = steps[index - 1]
      start = [start_point.latitude, start_point.longitude]
      finish = [step.latitude, set.longitude]
      url = `https://api.mapbox.com/directions/v5/mapbox/driving/#{start[1]},#{start[0]};#{finish[1]},#{finish[0]}?steps=true&geometries=geojson&access_token=${mapboxgl.accessToken}`
      json = JSON.parse(URI.open(url))
      data = json.routes[0]
      route =  data.geometry.coordinates
      step.route = route
    end
  end

end
