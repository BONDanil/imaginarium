class ApplicationController < ActionController::Base
  def update_game_view(game)
    game.players.each do |player|
      Turbo::StreamsChannel.broadcast_update_later_to(
        [game, player.user],
        target: "game_player_#{player.id}",
        partial: "games/actual_state",
        locals: { game: game, current_player: player }
      )
    end
  end
end
