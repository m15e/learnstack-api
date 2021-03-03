class AddVotesToStacks < ActiveRecord::Migration[6.0]
  def change
    add_column :stacks, :upvotes, :integer
    add_column :stacks, :downvotes, :integer
  end
end
