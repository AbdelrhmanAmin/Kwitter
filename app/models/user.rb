class User < ApplicationRecord
  validates :username,  presence: true, length: { in: 3..12 }, format: { without: /\s/ }
  validates :fullname, presence: true, length: { maximum: 20 }
  validates :username,  uniqueness: true

  has_many :posts, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  ## ACTIVE RELATIONSHIPS: You [follower] following someone [followed]
  ## PASSIVE RELATIONSHIPS: Someone [follower] following you [followed]
  def follow(other)
    active_relationships.create(followed_id: other.id)
  end

  def unfollow(other)
    active_relationships.find_by(followed_id: other.id).destroy
  end

  def following?(other)
    following.include?(other)
  end
  
  has_one_attached :image
  has_one_attached :cover
end
