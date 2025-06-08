# TODO: move to concern
class BaseController < ApplicationController
  before_action :authenticate_user!

  helper_method :current_player

  def current_player
    if params[:game_id].present?
      Game.find(params[:game_id]).players.find_by(user_id: current_user)
    end
  end
end
