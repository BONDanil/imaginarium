class RoundsController < BaseController
  def create
    game.create_next_round!
    redirect_to game_path(game)
  end

  private

  def game
    @game ||= Game.find(params[:game_id])
  end
end
