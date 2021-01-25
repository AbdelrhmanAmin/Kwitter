class User < ApplicationRecord
  has_one_attached :image
  has_one_attached :cover
end
