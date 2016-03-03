class AddScoreToBrackets < ActiveRecord::Migration
  def change
    add_column :brackets, :score, :integer, default: 0
  end
end
