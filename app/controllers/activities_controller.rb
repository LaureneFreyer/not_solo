class ActivitiesController < ApplicationController
  before_action :set_user_address, only: :index

  def index
    if params[:query].present?
      sql_query = <<~SQL
        activities.title ILIKE :query
        OR activities.category ILIKE :query
        OR activities.content ILIKE :query
        OR activities.address ILIKE :query
        OR users.first_name ILIKE :query
      SQL
      @activities = Activity.joins(:user).where(sql_query, query: "%#{params[:query]}%")
    else
      @activities = Activity.all
    end

    if user_signed_in? && @user_address.present?
      user_coordinates = Geocoder.coordinates(@user_address)

      if user_coordinates.present?
        # Trouver les activités autour de l'utilisateur
        @activities = @activities.near(user_coordinates, 10, units: :km)
      end
    end

    params[:query] = nil
  end

  private

  def set_user_address
    @user_address = current_user&.address
  end
end
