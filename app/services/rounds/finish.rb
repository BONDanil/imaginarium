module Rounds
  class Finish
    attr_reader :round

    def initialize(round)
      @round = round
    end

    def call
      ActiveRecord::Base.transaction do
        game.players.each do |player|
          player.points += calculate_points_for(player)
          player.save!
        end

        round.finished!
      end
    end

    private

    def calculate_points_for(player)
      if round.host == player
        calculate_host_points(player)
      else
        calculate_player_points(player)
      end
    end

    def calculate_host_points(host)
      association = first_association_of(host)

      case association.votes.count
      when 0
        0
      when game.players.count - 1
        0
      else
        3
      end
    end

    def calculate_player_points(player)
      total_points = 0

      # check if player guessed host's card
      total_points += 3 if player.votes.joins(:game_association).where(associations: { round:, player: round.host }).any?

      # add count of votes for player's association
      association = first_association_of(player)
      total_points += association.votes.count
    end

    def first_association_of(player)
      round.associations.by_player(player).first
    end

    def game
      @game ||= round.game
    end
  end
end
