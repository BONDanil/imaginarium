class AssociationsController < ApplicationController
  def create
    # TODO: think about host/player association creation
    round.associations.create(association_params)
    round.players_choice!

    # TODO: update all players screen
    redirect_to game_round_path(round.game, round)
  end

  private

  def association_params
    params.require(:association).permit(:player_id, :image, :description)
  end

  def round
    @round ||= Round.find(params[:round_id])
  end
end
