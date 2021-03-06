class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :favorited, polymorphic: true

  validates :user_id, uniqueness: {
    scope: [:favorited_id, :favorited_type],
    message: 'can only favorite an item once'
  }
end
