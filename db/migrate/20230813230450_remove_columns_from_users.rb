class RemoveColumnsFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :tokens, :string
    remove_column :users, :token, :string
    remove_column :users, :uuid, :string
  end
end
