class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :school
      t.string :shortname
      t.string :mascot
      t.integer :seed
      t.integer :region_id
      t.integer :espn_id
      t.integer :tournament_id

      t.timestamps null: false
    end

    add_index :teams, [:tournament_id, :region_id, :seed], unique: true
  end
end
