require 'rails_helper'
feature 'User features ' do
  before do
    @user = create(:users)
    log_in
  end
  feature "User Settings Dashboard" do
    before(:each) do
      visit "/users/#{@user.id}/edit"
    end
    scenario "visit users edit page" do
      expect(page).to have_field('Name')
      expect(page).to have_field('Email')
      expect(page).to have_button('Update User')
    end
    scenario "inputs filled out correctly" do
      expect(find_field('Name').value).to eq(@user.name)
      expect(find_field('Email').value).to eq(@user.email)
    end
    scenario "correctly updates information" do
      fill_in 'Name', with: 'Bob Smith'
      fill_in 'Email', with: 'bobby@gmail.com'
      click_button 'Update User'
      expect(current_path).to eq("/users/#{@user.id}")
      expect(page).to have_text('Bob Smith')
    end
    scenario "incorrectly updates name" do
      fill_in 'Name', with: ''
      fill_in 'Email', with: 'email@email.com'
      click_button 'Update User'
      expect(page).to have_text("can't be blank")
      expect(current_path).to eq("/users/#{@user.id}/edit")
    end
    scenario "incorrectly updates email" do
      fill_in 'Name', with: 'Bob Smith'
      fill_in 'Email', with: 'emailemailcom'
      click_button 'Update User'
      expect(page).to have_text("Email is invalid")
      expect(current_path).to eq("/users/#{@user.id}/edit")
    end

    scenario "destroys users and redirects to registration page" do
      click_button 'Delete'
      expect(current_path).to eq('/users/new')
    end
  end
end