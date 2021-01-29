# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:fullname) }
    it { should validate_presence_of(:username) }
    it { should validate_length_of(:username).is_at_least(3) }
    it { should validate_length_of(:fullname).is_at_least(3) }
  end

  describe 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:events) }
    it { should have_many(:following) }
    it { should have_many(:followers) }
    it { should have_many(:attendances).with_foreign_key(:user_id).class_name('Attendee') }
    it { should have_many(:attended_events) }
  end
end
