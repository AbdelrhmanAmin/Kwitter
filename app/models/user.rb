class User < ApplicationRecord
  validates :username,  presence: true, length: { in: 3..12 }, format: { without: /\s/ }
  validates :fullname, presence: true, length: { maximum: 20 }
  validates :username,  uniqueness: true
  has_many :posts

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Following'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Following'
  has_many :followers, through: :following_users
  has_one_attached :image
  has_one_attached :cover
end
