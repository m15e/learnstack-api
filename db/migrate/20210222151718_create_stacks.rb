class CreateStacks < ActiveRecord::Migration[6.0]
  def change
    create_table :stacks do |t|
      t.string :title
      t.string :tags

      t.timestamps
    end
  end
end
