class User < ApplicationRecord
  has_secure_password

  has_many :stacks
  has_many :favorites
  has_many :favorite_stacks, through: :favorites, source: :favorited, source_type: 'Stack'
end
