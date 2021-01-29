require 'rails_helper'

RSpec.feature 'Following', type: :feature do
  before :each do
    @user1 = User.create!(fullname: 'Ali Zien', username: 'Ali_Zien')
    @user2 = User.create!(fullname: 'Abdo Amin', username: 'Abdo_Amin')
  end
  it 'Should be able to follow a user' do
    visit login_path
    fill_in 'username', with: 'Ali_Zien'
    find("input[type='submit']").click
    click_on 'Abdo Amin'
    expect(page).to have_content('Follow')
  end

  it 'Should be able to unfollow a user' do
    visit login_path
    fill_in 'username', with: 'Ali_Zien'
    find("input[type='submit']").click
    click_on 'Abdo Amin'
    click_on 'Follow'
    click_on 'Unfollow'
    expect(page).to have_content('Follow')
  end
end
