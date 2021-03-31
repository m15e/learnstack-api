class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :stack

  # validates :user_id, uniqueness: {
  #   scope: %i[favorited_id],
  #   message: 'can only favorite an item once'
  # }
end
