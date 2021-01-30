# rubocop:disable Metrics/BlockLength
require 'rails_helper'

RSpec.feature 'Authentications', type: :feature do
  before :each do
    @user = User.create!(fullname: 'user', username: 'user1')
  end

  it 'Should NOT Signup' do
    visit signup_path
    fill_in 'user[fullname]', with: 'new_user1'
    fill_in 'user[username]', with: 'newuser1'
    click_button 'Join the cathood 😽'
    expect(page).to have_text('error prohibited this user from being saved')
  end
  it 'Should NOT Signup' do
    visit signup_path
    fill_in 'user[fullname]', with: 'new-user'
    fill_in 'user[username]', with: 'newuser1'
    click_button 'Join the cathood 😽'
    expect(page).to have_text('error prohibited this user from being saved')
  end

  it 'Should Signup' do
    visit signup_path
    fill_in 'user[fullname]', with: 'user'
    fill_in 'user[username]', with: 'user1'
    click_button 'Join the cathood 😽'
    expect(page).to_not have_text('error prohibited this user from being saved')
    expect(page).to have_content(@user.fullname)
  end

  it 'Should Login' do
    visit root_path
    visit '/login'
    fill_in 'username', with: 'user1'
    find("input[type='submit']").click
    expect(page).to have_content(@user.fullname)
    expect(page).to have_content('Profile')
  end

  it 'Should Logout' do
    visit '/login'
    fill_in 'username', with: 'user1'
    find("input[type='submit']").click
    expect(page).to have_content(@user.fullname)
    expect(page).to have_content('Profile')
    click_on 'logout'
    expect(page).to have_content('Login')
  end
end
# rubocop:enable Metrics/BlockLength
