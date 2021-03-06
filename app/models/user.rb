# rubocop:disable Style/GuardClause

class User < ApplicationRecord
  validates :username, presence: true, length: { in: 3..12 }, format: { without: /\s/ }, uniqueness: true
  validates :fullname, presence: true, length: { in: 3..25 }, format: { with: /\A[a-zA-Z ]+\z/ }, uniqueness: true
  has_one_attached :image
  has_one_attached :cover
  validate :image_type
  has_many :posts, dependent: :destroy
  has_many :events, foreign_key: :creator_id

  has_many :active_relationships, class_name: 'Following', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name: 'Following', foreign_key: 'followed_id', dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :attendances, class_name: 'Attendee', foreign_key: :user_id
  has_many :attended_events, through: :attendances
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
    user.cover.variant(resize: '850x250!').processed
  end

  def profile_picture(user)
    user.image.variant(resize: '50x50!').processed
  end

  private

  def image_type
    if image.attached? && !image.content_type.in?(%w[image/jpeg image/png image/gif])
      errors.add(:image, 'Must be JPEG OR PNG OR GIF!')
    end
    if cover.attached? && !cover.content_type.in?(%w[image/jpeg image/png image/gif])
      errors.add(:cover, 'Must be JPEG OR PNG OR GIF!')
    end
  end
end
# rubocop:enable Style/GuardClause
