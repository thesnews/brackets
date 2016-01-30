class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :tournament_id
      t.integer :team1_id
      t.integer :team2_id
      t.integer :score1
      t.integer :score2
      t.integer :position
      t.datetime :start_time
      t.boolean :final, default: false

      t.timestamps null: false
    end

    add_index :games, [:tournament_id, :position], unique: true
  end
end
