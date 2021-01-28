class Attendee < ApplicationRecord
  validates :user_id, presence: true
  validates :event_id, presence: true
  belongs_to :attendee, class_name: 'User', foreign_key: :user_id
  belongs_to :attended_event, class_name: 'Event', foreign_key: :event_id
end
