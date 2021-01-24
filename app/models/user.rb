class User < ApplicationRecord
  validates :username, length: { in: 3..12 }
  validates :fullname, presence: true, length: { maximum: 20 }
  validates :username, :email, :password, presence: true
  validates :username, :email, uniqueness: true
  validates :password, length: { in: 6..16 }
  has_many :posts
  has_many :followings
  has_one_attached :image, :dependent => :destroy
end
