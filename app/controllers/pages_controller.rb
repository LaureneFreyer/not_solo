class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    session[:current_page] = 'home'

    @activities = Activity.all
    @likes = Like.where(user: current_user)
  end

  def cherche
  end
end
