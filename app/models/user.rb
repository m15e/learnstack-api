class User < ApplicationRecord
  has_secure_password

  has_many :stacks
  has_many :favorites, through: :stacks, foreign_key: :user_id
end
