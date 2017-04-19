require 'rails_helper'
feature 'User features ' do
  before do
    @user = create(:users)
  end
  feature "users sign-up" do
    before(:each) do
      visit '/users/new'
    end
    scenario 'visits sign-up page' do
      expect(page).to have_field('Name')
      expect(page).to have_field('Email')
      expect(page).to have_field('Password')
      expect(page).to have_field('Password Confirmation')
    end
    scenario "with improper inputs, redirects back to sign in and shows validations" do
      click_button 'Join'
      expect(current_path).to eq('/users/new')
      expect(page).to have_text("can't be blank")
    end
    scenario "with proper inputs, create users and redirects to login page" do
      fill_in 'Name', with: 'Jonathan Scott'
      fill_in 'Email', with: 'Jonathan@jon.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password Confirmation', with: 'password'
      click_button 'Join'
      expect(current_path).to eq("/sessions/new")
    end
  end
  feature "users dashboard" do
    before do
      log_in
    end
    scenario "displays users information" do
      expect(page).to have_text("#{@user.name}")
      expect(page).to have_link('Edit Profile')
    end
  end
end