class MomentsController < ApplicationController
  def new
    @moment = Moment.new
  end

  def create
    @moment = Moment.new(params[:moment])
    @moment.save
  end

  def destroy
    @moment = Moment.find(params[:id])
    @moment.destroy
    redirect_to moments_path, status: :see_other
  end
end

private

def moment_params
  params.require(:moment).permit(:description, :location, :date)
end
