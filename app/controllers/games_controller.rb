class GamesController < BaseController
  before_action :validate_current_user!, only: :show
  helper_method :current_player

  def index
    # TODO: show not only hosted games
    @games = current_user.games.all
  end

  def create
    current_player = current_user.players.create
    game = current_user.games.create(players: [current_player], image_pack: ImagePack.first)
    redirect_to game_path(game)
  end

  def show
    current_player
  end

  def start
    ActiveRecord::Base.transaction do
      game.update!(host_ids_order: game.players.ids.shuffle)
      game.in_progress!
      game.create_next_round!
      game.distribute_images!
    end

    update_game_view(game)
  end

  private

  def validate_current_user!
    return if game.valid_user?(current_user)

    flash[:alert] = "You do not have access to this game!"
    redirect_to request.referer || root_path
  end

  def current_player
    @current_player ||= game.player_by_user(current_user)
  end

  def game
    @game ||= Game.find(params[:id])
  end
end
