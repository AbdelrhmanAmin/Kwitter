class User < ApplicationRecord
  has_many :posts
  has_many :followings
  has_one_attached :image, :dependent => :destroy
end
