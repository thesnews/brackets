
class TournamentsController < ApplicationController
  def show
    @tournament = Tournament
      .includes(games: [:team1, :team2])
      .find(params[:id])
  end
end
