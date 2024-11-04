class VotesController < BaseController
  def create
    Vote.create(player: game.player_by_user(current_user), **vote_params)
    update_game_view(game)
  end

  private

  def game
    @game ||= Game.find_by(id: params[:game_id])
  end

  def vote_params
    params.require(:vote).permit(:association_id)
  end
end
