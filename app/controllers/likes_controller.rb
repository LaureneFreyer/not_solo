class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = Like.new(user_id: current_user.id, activity_id: params[:activity_id])

    if @like.save
      redirect_to activity_path(params[:activity_id]), notice: 'Activité ajoutée aux favoris avec succès!'
    else
      redirect_to activity_path(params[:activity_id]), alert: 'Un problème est survenu lors de l\'ajout de l\'activité aux favoris.'
    end
  end
end
