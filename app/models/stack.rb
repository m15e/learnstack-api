class Stack < ApplicationRecord
  validates :title, presence: true, length: { minimum: 1 }
  validates :tags, presence: true, length: { minimum: 1 }

  belongs_to :user
  has_many :links  
end
