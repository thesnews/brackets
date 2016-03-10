class Admin::TeamsController < Admin::BaseController
  def new
    @tournament = Tournament.find(params[:tournament_id])
    @team = @tournament.teams.build
  end

  def create
    @tournament = Tournament.find(params[:tournament_id])
    @team = @tournament.teams.build(team_params)
    if @team.save
      redirect_to [:admin, @team.tournament]
    else
      render 'new'
    end
  end

  def edit
    @team = Team
      .includes(:tournament)
      .find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(team_params)
      flash[:success] = "Your team has been updated."
      redirect_to [:edit, :admin, @team.tournament, @team]
    else
      render 'edit'
    end
  end

  private
  def team_params
    params.require(:team).permit(
      :school,
      :shortname,
      :mascot,
      :seed,
      :region_id,
      :espn_id
    )
  end

end
