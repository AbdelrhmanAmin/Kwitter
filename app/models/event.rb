# rubocop:disable Style/GuardClause

class Event < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :date, presence: true
  validates :content, presence: true
  belongs_to :creator, class_name: 'User'
  has_many :attendees, dependent: :destroy
  has_many :attendances, through: :attendees, source: :attendee
  has_one_attached :cover
  validate :image_type
  after_save :auto_populate_creator
  def auto_populate_creator
    attendances << creator if attendances.empty?
  end

  def included?(user)
    attendance_ids.include?(user.id)
  end

  def created_by?(user)
    creator_id != user.id
  end
  scope :old_events, -> { where(['events.date < ?', Date.today]) }
  scope :coming_events, -> { where(['events.date >= ?', Date.today]) }
  def cover_event(event)
    event.cover.variant(resize: '400x250!').processed
  end

  private

  def image_type
    if cover.attached? && !cover.content_type.in?(%w[image/jpeg image/png image/gif])
      errors.add(:cover, 'Must be JPEG OR PNG OR GIF!')
    end
  end
end
# rubocop:enable Style/GuardClause
