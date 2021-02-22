class Stack < ApplicationRecord
  validates :title, presence: true, length: { minimum: 4 }
  validates :tags, presence: true, length: { minimum: 3 }
end
