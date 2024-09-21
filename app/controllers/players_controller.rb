class PlayersController < BaseController
  def create
    game.players.create(user: current_user)
  end

  private

  def game
    @game ||= Game.find(params[:game_id])
  end
end
