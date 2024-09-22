class RoundsController < BaseController
  def create
    game.create_next_round!
  end

  private

  def game
    @game ||= Game.find(params[:game_id])
  end
end
