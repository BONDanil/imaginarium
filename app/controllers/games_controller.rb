class GamesController < BaseController
  before_action :validate_current_user!, only: :show

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
    current_user_role
    current_player

    # if game.created?
    #   if game.user == current_user
    #     render "games/host/show"
    #   else
    #     render "games/players/show"
    #   end
    # else
    #   redirect_to game_round_path(game, game.rounds.ordered.last)
    # end
  end

  def start
    # TODO: add logic of linking of images to each player
    game.update!(host_ids_order: game.players.ids.shuffle)
    game.in_progress!
    game.create_next_round!
    redirect_to game_path(game)
  end

  private

  def validate_current_user!
    return if game.valid_user?(current_user)

    flash[:alert] = "You do not have access to this game!"
    redirect_to request.referer || root_path
  end

  def current_user_role
    @current_user_role ||= game.user_role(current_user)
  end

  def current_player
    @current_player ||= game.players.find_by(user: current_user)
  end

  def game
    @game ||= Game.find(params[:id])
  end
end
