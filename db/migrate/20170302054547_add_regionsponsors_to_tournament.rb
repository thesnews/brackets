class AddRegionsponsorsToTournament < ActiveRecord::Migration
  def change
    add_column :tournaments, :region_sponsor0, :string
    add_column :tournaments, :region_sponsor1, :string
    add_column :tournaments, :region_sponsor2, :string
    add_column :tournaments, :region_sponsor3, :string
  end
end
