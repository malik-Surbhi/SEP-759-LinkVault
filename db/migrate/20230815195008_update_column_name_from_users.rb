class UpdateColumnNameFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :uid
    change_column_default :users, :provider, 'email'
  end
end
