class RoundsController < BaseController
  def create
    game.create_next_round!
    update_game_view(game)
  end

  private

  def game
    @game ||= Game.find(params[:game_id])
  end
end
