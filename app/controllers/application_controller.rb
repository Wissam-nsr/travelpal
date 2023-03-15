class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # before_action :set_moment
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar, :username, :address])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :username, :address])
  end

  private

  # def set_moment
  #   @moment = Moment.new
  #   @trip = current_user.trips.last
  #   @moment.trip = current_user.trips.last if current_user
  # end
end
