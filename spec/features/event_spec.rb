require 'rails_helper'

RSpec.feature 'Events', type: :feature do
  before :each do
    @user1 = User.create!(fullname: 'Ali Zien', username: 'Ali_Zien')
    @user2 = User.create!(fullname: 'Abdo Amin', username: 'Abdo_Amin')
    @event = Event.new( title: "Let's meditate", date: Date.today,
                          content: 'I love to meditate a lot!!!')
  end

  it 'Should create a post' do
    visit root_path
    visit login_path
    fill_in 'username', with: 'Ali_Zien'
    find("input[type='submit']").click
    @event.creator_id = @user1.id
    @event.save
    visit event_path(@event)
    expect(page).to have_content("Let's meditate")
  end

  it 'Should Not create a post' do
    visit root_path
    visit login_path
    fill_in 'username', with: 'Ali_Zien'
    find("input[type='submit']").click
    @event.save
    expect(@event).to_not eql(true)
  end
  
end
