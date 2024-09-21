class GamesController < BaseController
  def index
    # TODO: show not only hosted games
    @games = current_user.games.all
  end

  def create
    current_player = current_user.players.create
    game = current_user.games.create(players: [current_player])
    redirect_to game_path(game)
  end

  def show
    # TODO: add error for not related user

    if game.created?
      if game.user == current_user
        render "games/host/show"
      else
        render "games/players/show"
      end
    else
      redirect_to game_round_path(game, game.rounds.ordered.last)
    end
  end

  def start
    # TODO: add logic of linking of images to each player
    game.update!(host_ids_order: game.players.ids.shuffle)

    # TODO: DRY with rounds#create
    round = game.rounds.create(host: game.current_host)
    redirect_to game_round_path(game, round)
  end

  private

  def game
    @game ||= Game.find(params[:id])
  end
end
