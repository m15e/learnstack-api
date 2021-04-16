class RenameFavoritedToStacksInFavorites < ActiveRecord::Migration[6.0]
  def change
    rename_column :favorites, :favorited_id, :stack_id
  end
end
