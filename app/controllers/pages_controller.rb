class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :landing, :home ]

  def home
    if user_signed_in?
      @radius = params[:radius].present? ? params[:radius].to_i : 150
      @users = User.near([current_user.latitude,current_user.longitude], @radius)
      @markers = @users.geocoded.map do |user|
        {
          lat: user.latitude,
          lng: user.longitude,
          info_window_html: render_to_string(partial: "info_window", locals: {user: user}),
          marker_html: render_to_string(partial: "marker", locals: {user: user})
        }
      end
    else
      redirect_to landing_path unless user_signed_in?
    end
  end

  def landing
  end

  def map
    radius = params[:radius].present? ? params[:radius].to_i : 150
    @users = User.near([current_user.latitude,current_user.longitude],radius)
    @markers = @users.geocoded.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {user: user}),
        marker_html:
          if user == current_user
            render_to_string(partial: "components/marker_here", locals: {user: user})
          else
            render_to_string(partial: "marker", locals: {user: user})
          end
      }
    end
  end
end
