class AddStackToLinks < ActiveRecord::Migration[6.0]
  def change
    add_reference :links, :stack
  end
end
