require 'rails_helper'
feature "secret features" do
  before(:each) do
    @user = create(:users)
    @user2 = create(:users, email: 'user2@gmail.com')
    @secret2 = create(:secret, users: @user2, content: 'Hidden from @users')
    log_in
  end
  feature "Users personal secret page" do
    before(:each) do
      visit "/users/#{@user.id}"
    end
    scenario "shouldn't see other users's secrets" do
      expect(page).to_not have_text(@secret2.content)
    end
    scenario "create a new secret" do
      fill_in 'content', with: 'First users secret'
      click_button 'Create Secret'
      expect(current_path).to eq("/users/#{@user.id}")
      expect(page).to have_text('First users secret')

    end
    scenario "destroy secret from profile page, redirects to users profile page" do
      secret = create(:secret, users: @user)
      visit "/users/#{@user.id}"
      click_button('Delete Secret')
      expect(current_path).to eq("/users/#{@user.id}")
      expect(page).not_to have_text(secret.content)
    end
  end
  feature "Secret Dashboard" do
    before do
      @secret = create(:secret, users: @user)
    end
    before(:each) do
      visit "/secrets"
    end
    scenario "displays everyone's secrets" do
      expect(page).to have_text(@secret.content)
      expect(page).to have_text(@secret2.content)
    end
    scenario "destroy secret from index page, redirects to users profile page" do
      click_button 'Delete Secret'
      expect(current_path).to eq("/users/#{@user.id}")
      expect(page).not_to have_text(@secret.content)
    end
  end
end