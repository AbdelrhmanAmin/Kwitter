class User < ApplicationRecord
  validates :username,  presence: true, length: { in: 3..12 }
  validates :fullname, presence: true, length: { maximum: 20 }
  validates :username,  uniqueness: true
  has_many :posts
  has_many :followings
  has_one_attached :image
  has_one_attached :cover
end
