class RemoveTagsFromLink < ActiveRecord::Migration[6.0]
  def up
    remove_column :links, :tags
  end

  def down
    add_column :links, :tags, :string
  end
end
