
class TournamentsController < ApplicationController
  def show
    @tournament = Tournament
      .includes(games: [:team1, :team2])
      .find(params[:id])
    @tournament_json = @tournament.to_json(
      include: {
        games: {
          include: [:team1, :team2]
        }
      }
    )
  end
end