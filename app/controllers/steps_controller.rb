require "json"
require "open-uri"

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
    params.require(:step).permit(:name, :description, :date, :location)
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


    const query = await fetch(
      `https://api.mapbox.com/directions/v5/mapbox/driving/${start[1]},${start[0]};${end[1]},${end[0]}?steps=true&geometries=geojson&access_token=${mapboxgl.accessToken}`
    );
    const json = await query.json();
    const data = json.routes[0];
    const route = data.geometry.coordinates;
    return route
