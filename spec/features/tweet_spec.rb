require 'rails_helper'

RSpec.feature 'Posts', type: :feature do
  before :each do
    @user1 = User.create!(fullname: 'Ali Zien', username: 'Ali_Zien')
    @user2 = User.create!(fullname: 'Abdo Amin', username: 'Abdo_Amin')
    Post.create(user_id: @user1.id, content: 'my first post')
  end

  it 'Should create an opinion' do
    visit root_path
    visit login_path
    fill_in 'username', with: 'Ali_Zien'
    find("input[type='submit']").click
    fill_in 'post[content]', with: 'This is a tweet'
    click_button 'TWEET'
    expect(page).to have_content('This is a tweet')
  end
end