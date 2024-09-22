class PlayersController < BaseController
  def create
    game.players.create(user: current_user) if game.player_by_user(current_user).blank?
    redirect_to game_path(game)
  end

  private

  def game
    @game ||= Game.find(params[:game_id])
  end
end
