class ChangeProfilePhotoColumnType < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :profile_photo, :binary
  end

  def up
    # Change the data type of the profile_photo column to binary or blob
    change_column :users, :profile_photo, :binary
  end
end
