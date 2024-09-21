class RoundsController < BaseController
  def create
    @round = game.rounds.create(host: game.current_host)
    redirect_to game_rounds_path(@round)
  end

  def show
    if round.host == current_player
      render "rounds/host/show/#{round.status}"
    else
      render "rounds/players/show/#{round.status}"
    end
  end

  private

  def round
    @round ||= game.rounds.find(params[:id])
  end

  def game
    @game ||= Game.find(params[:game_id])
  end
end
