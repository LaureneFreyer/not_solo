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

    unless @activity.geocoded?
      coordinates = Geocoder.coordinates(@activity.address.gsub(/\A([^,]+,)/, '')) # le gsub retire tous ce qu'il y avant la première virgule dans l'addresse, "unless" permet que ça ne s'exécute que si l'adresse ne s'est pas géocodée toute seule
      @activity.latitude = coordinates.first
      @activity.longitude = coordinates.last
    end

    if @activity.save
      @chatroom = Chatroom.create!(name: @activity.title, activity: @activity)
      redirect_to activity_path(@activity)
    else
      flash.now[:alert] = "Veuillez corriger les erreurs dans le formulaire."
      render :new, status: :unprocessable_entity
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

  def categories
    @categories = Activity.distinct.pluck(:category)
  end

  def by_category
    @category = params[:category]
    @activities = Activity.where(category: @category)
  end

  def my_activities
    @activities = current_user.activities
  end

  def requests
    @activity = Activity.find(params[:id])
    @reservations = @activity.reservations.pending
    @requests = Reservation.where(status: 'envoyée')
  end

  def current_participants
    reservations.where(status: "accepted").count
  end




  private

  def set_user_address
    @user_address = current_user&.address
  end

  def activity_params
    params.require(:activity).permit(:category, :latitude, :longitude, :title, :price_person, :content, :address, :start_date, :end_date)
  end

end
