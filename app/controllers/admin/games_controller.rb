class Admin::GamesController < Admin::BaseController
  def edit
    @game = Game
      .includes(:tournament)
      .find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @game.update_attributes(game_params)
      flash[:success] = "Your game has been updated."
      redirect_to [:admin, @game.tournament]
    else
      render 'edit'
    end
  end

  private
  def game_params
    params.require(:game).permit(
      :team1_id,
      :team2_id,
      :score1,
      :score2,
      :start_time,
      :final
    )
  end

end
