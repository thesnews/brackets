class TournamentsController < ApplicationController
  def index
    @tournaments = Tournament.live
  end

  def show
    @tournament = Tournament
      .includes(games: [:team1, :team2])
      .friendly.find(params[:id])

    if not @tournament.live? and current_user.try(:role) != 'admin'
      raise ActiveRecord::RecordNotFound
    end

    if user_signed_in?
      @bracket = @tournament.brackets.find_by_user_id(current_user)
    end
  end

  def challenge
    @tournament = Tournament.friendly.live.find(params[:id])
  end

  def leaderboard
    @tournament = Tournament.friendly.live.find(params[:id])
    @brackets = @tournament.top_brackets(125)
    fetch_featured_brackets(@tournament)
    if user_signed_in?
      @user_bracket = @tournament.brackets.find_by_user_id(current_user.id)
      @display_user_bracket = @user_bracket &&
        !@brackets.map(&:first).include?(@user_bracket)
    end
  end

  private
  def fetch_featured_brackets(tournament)
    ids = tournament.featured.map { |info| info['id'] }
    brackets = tournament.brackets.includes(:user).where(id: ids)
    brackets = brackets.map do |bracket|
      [bracket.id, bracket]
    end
    brackets = Hash[brackets]
    tournament.featured.each do |info|
      info['bracket'] = brackets[info['id']]
      if info['bracket'].picks[62]
        info['champion'] = Team.find(info['bracket'].picks[62])
      end
    end
  end
end
