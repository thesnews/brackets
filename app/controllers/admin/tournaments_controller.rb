class Admin::TournamentsController < ApplicationController
  layout 'admin'

  def index
    @tournaments = Tournament.paginate(page: params[:page])
  end

  def show
    @tournament = Tournament.find(params[:id])
    @teams = @tournament.teams.order(:school)
    @games = @tournament.games.order(:position)
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(tournament_params)
    if @tournament.save
      redirect_to admin_tournaments_path
    else
      render 'new'
    end
  end

  def edit
    @tournament = Tournament.find(params[:id])
  end

  def update
    @tournament = Tournament.find(params[:id])
    puts params

    if @tournament.update_attributes(tournament_params)
      redirect_to admin_tournaments_path
    else
      render 'edit'
    end
  end

  private
  def tournament_params
    params.require(:tournament).permit(
      :name,
      :event,
      :start_date,
      :region0,
      :region1,
      :region2,
      :region3
    )
  end
end
