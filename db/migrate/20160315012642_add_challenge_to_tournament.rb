class AddChallengeToTournament < ActiveRecord::Migration
  def change
    add_column :tournaments, :challenge_text, :text
  end
end
