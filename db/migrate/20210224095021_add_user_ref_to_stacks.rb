class AddUserRefToStacks < ActiveRecord::Migration[6.0]
  def change
    add_reference :stacks, :user, null: false, foreign_key: true
  end
end
