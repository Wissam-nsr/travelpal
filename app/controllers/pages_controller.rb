class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :landing ]

  def home
    @users = User.near([current_user.latitude,current_user.longitude],200)
    @markers = @users.geocoded.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {user: user})
      }
    end
  end

  def landing
  end

end
