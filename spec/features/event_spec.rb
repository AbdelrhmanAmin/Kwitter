require 'rails_helper'

RSpec.feature 'Events', type: :feature do
  before :each do
    @user1 = User.create!(fullname: 'Ali Zien', username: 'Ali_Zien')
    @user2 = User.create!(fullname: 'Abdo Amin', username: 'Abdo_Amin')
    @event = Event.create(creator_id: @user1.id, title: "Let's meditate", date: Date.today,
                          content: 'I love to meditate a lot!!!')
  end

  it 'Should create an opinion' do
    visit root_path
    visit login_path
    fill_in 'username', with: 'Ali_Zien'
    find("input[type='submit']").click
    visit event_path(@event)
    expect(page).to have_content("Let's meditate")
  end
end
