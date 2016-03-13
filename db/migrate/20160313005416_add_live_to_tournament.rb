class AddLiveToTournament < ActiveRecord::Migration
  def change
    add_column :tournaments, :live, :boolean, default: false
    add_index :tournaments, :live
  end
end
