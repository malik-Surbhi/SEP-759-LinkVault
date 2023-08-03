class RemoveActiveAndPublicFromLinks < ActiveRecord::Migration[7.0]
  def change
    remove_column :links, :active, :boolean
    remove_column :links, :public, :boolean
  end
end
