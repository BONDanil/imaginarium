class PlayersController < BaseController
  def create
    if game.player_by_user(current_user).blank?
      new_player = game.players.create(user: current_user)

      # TODO: reuse some code with application_controller#update_game_view
      game.players.except(new_player).each do |player|
        Turbo::StreamsChannel.broadcast_append_later_to(
          [game, player.user],
          target: "players_list",
          partial: "shared/players/list_item",
          locals: { player: new_player }
        )
      end
    end

    redirect_to game_path(game)
  end

  private

  def game
    @game ||= Game.find(params[:game_id])
  end
end
