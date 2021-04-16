class RemoveFavoritedTypeFromFavorites < ActiveRecord::Migration[6.0]
  def up
    remove_column :favorites, :favorited_type, :string
  end
  
  def down
    add_column :favorites, :favorited_type, :string
  end
end
