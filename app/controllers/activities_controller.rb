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
      @user_coordinates = Geocoder.coordinates(@user_address)

      if @user_coordinates.present?
        # Trouver les activités autour de l'utilisateur
        @activities = @activities.near(@user_coordinates, 10, units: :km)
        @user_coordinates = @user_coordinates.reverse # Inverser l'ordre des coordonnées (latitude, longitude -> longitude, latitude)
      end
    end


    params[:query] = nil

    @markers = @activities.map do |activity|
      {
        lat: activity.latitude,
        lng: activity.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {activity: activity}),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.user = current_user # suppose que l'utilisateur est connecté

    if @activity.address.present?
      coordinates = Geocoder.coordinates(@activity.address)
      @activity.latitude = coordinates.first
      @activity.longitude = coordinates.last
    end

    if @activity.save
      redirect_to activity_path(@activity)
    else
      flash.now[:alert] = "Veuillez corriger les erreurs dans le formulaire."
      render :new
    end
  end


  def show
    @activity = Activity.find(params[:id])
    @marker = {
      lat: @activity.latitude,
      lng: @activity.longitude,
      info_window_html: render_to_string(partial: "info_window", locals: { activity: @activity }),
      marker_html: render_to_string(partial: "marker", locals: { activity: @activity })
    }
  end



  private

  def set_user_address
    @user_address = current_user&.address
  end

  def activity_params
    params.require(:activity).permit(:category, :latitude, :longitude, :title, :price_person, :content, :address, :start_date, :end_date)
  end

end
