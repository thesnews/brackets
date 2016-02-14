class CreateBrackets < ActiveRecord::Migration
  def change
    create_table :brackets do |t|
      t.integer :tournament_id
      t.integer :user_id
      t.text :picks

      t.timestamps null: false
    end

    add_index :brackets, [:tournament_id, :user_id], unique: true
  end
end
