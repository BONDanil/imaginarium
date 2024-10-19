class AssociationsController < ApplicationController
  before_action :validate_player!

  def create
    round.associations.create(association_params)

    # TODO: update all players screen
    redirect_to game_path(game)
  end

  private

  def round
    @round ||= Round.find(params[:round_id])
  end

  def game
    @game ||= round.game
  end

  def current_player
    @current_player ||= game.player_by_user(current_user)
  end

  def association_params
    params
      .require(:association)
      .permit(:image_id, :description)
      .merge(player: current_player)
  end

  def validate_player!
    return if round.host_association.present?

    redirect_to request.referer if current_player != round.host
  end
end
