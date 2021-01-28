require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:content) }
    it { should have_many(:attendees) }
    it { should have_many(:attendees) }
  end

  describe 'associations' do
    it { should belong_to(:creator) }
  end
end