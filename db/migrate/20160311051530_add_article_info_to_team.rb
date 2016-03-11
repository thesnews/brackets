class AddArticleInfoToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :article_url, :string
    add_column :teams, :preview, :text
  end
end
