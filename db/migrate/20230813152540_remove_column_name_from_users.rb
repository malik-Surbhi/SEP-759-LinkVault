class RemoveColumnNameFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :uid, :string
    remove_column :users, :allow_password_change, :string
    remove_column :users, :name, :string
    remove_column :users, :tokens, :string
    remove_column :users, :provider, :string
    remove_column :users, :nickname, :string
    remove_column :users, :image, :string
    remove_column :users, :unconfirmed_email, :string
    remove_column :users, :confirmation_sent_at, :string
    remove_column :users, :confirmed_at, :string
    remove_column :users, :confirmation_token, :string
  end
end
