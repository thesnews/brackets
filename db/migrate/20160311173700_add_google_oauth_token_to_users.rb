class AddGoogleOauthTokenToUsers < ActiveRecord::Migration
  def change
    rename_column :users, :uid, :facebook_uid
    remove_column :users, :provider, :string
    add_column :users, :google_uid, :string
  end
end
