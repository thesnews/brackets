class Admin::TournamentsController < Admin::BaseController
  layout 'admin'

  def index
    @tournaments = Tournament.paginate(page: params[:page])
  end

  def show
    @tournament = Tournament.friendly.find(params[:id])
    @teams = @tournament.teams.order(:school)
    @games = @tournament.games.order(:position)
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(tournament_params)
    if @tournament.save
      0.upto(62) do |position|
        @tournament.games.create!(position: position, start_time: @tournament.start_date).update_teams
      end
      redirect_to admin_tournaments_path
    else
      render 'new'
    end
  end

  def edit
    @tournament = Tournament.friendly.find(params[:id])
  end

  def update
    @tournament = Tournament.friendly.find(params[:id])

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
      :region3,
      :live,
      :challenge_text
    )
  end
end
