class PlayersController < BaseController
  before_action :validate_current_player

  def create
    game.players.create(user: current_user)
  end

  private

  def game
    @game ||= Game.find(params[:game_id])
  end
end
