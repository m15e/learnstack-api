class User < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :username
  validates :username, presence: true
  validates :password, presence: true
  has_many :stacks
  has_many :favorites, through: :stacks, foreign_key: :user_id
end
