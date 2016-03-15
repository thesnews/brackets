module TournamentsHelper
  def tournament_json(tournament)
    tournament.to_json(tournament_json_options)
  end

  def tournament_bracket_json(bracket)
    bracket
      .as_json(tournament_bracket_json_options(bracket))
      .merge({
        editable: current_user == bracket.user
      })
      .to_json
  end

  def tournament_json_options
    {
      include: {
        games: {
          include: [:team1, :team2],
        }
      }
    }
  end

  def tournament_bracket_json_options(bracket)
    {
      include: { tournament: tournament_json_options },
    }
  end

  def bracket_freeze_time_in_words(tournament)
    time_ago = time_ago_in_words(tournament.start_date)
    if tournament.started?
      "Brackets froze #{time_ago} ago"
    else
      "Brackets freeze in #{time_ago}"
    end
  end
end
