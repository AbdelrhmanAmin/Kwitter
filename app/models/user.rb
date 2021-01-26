class User < ApplicationRecord
  validates :username,  presence: true, length: { in: 3..12 }, format: { without: /\s/ }
  validates :fullname, presence: true, length: { maximum: 20 }
  validates :username,  uniqueness: true
  has_one_attached :image
  has_one_attached :cover
  validate :image_type
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
  def thumbnail(user)
    return user.cover.variant(resize: "850x250!").processed
  end
  def profile_picture(user)
    return user.image.variant(resize: "50x50!").processed
  end
  
  private
  def image_type
    if image.attached? == false
      errors.add(:image, "is missing!")
    end
    if cover.attached? == false
      errors.add(:cover, "is missing!")
    end
    if image.attached? && !image.content_type.in?(%w(image/jpeg image/png image/gif))
      errors.add(:image, "Must be JPEG OR PNG OR GIF!")
    end
    if cover.attached? && !cover.content_type.in?(%w(image/jpeg image/png image/gif))
      errors.add(:cover, "Must be JPEG OR PNG OR GIF!")
    end
  end
end
