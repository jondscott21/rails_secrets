require 'rails_helper'
feature 'Like Features' do
  before(:each) do
    @user = create(:users)
    log_in
    @secret = create(:secret, users: @user)
  end
  feature 'secret has not been liked' do
    before(:each) do
      visit '/secrets'
    end
    scenario "like count updated correctly" do
      expect(page).to have_text(@secret.content)
      expect(page).to have_text('0 likes')
    end
    scenario "displays like button if you haven't liked secret" do
      expect(page).to have_button('Like')
    end
    scenario "liking will update like count, like button not visible" do
      click_button 'Like'
      expect(page).to_not have_button('Like')
      expect(page).to have_text('1 likes')
    end
  end
  feature "secret has been liked" do
    before(:each) do
      @like = create(:like, users: @user, secret: @secret)
      visit '/secrets'
    end
    scenario "unlike button is visible" do
      expect(page).to have_button('Unlike')
    end
    scenario "unliking will update like count" do
      click_button 'Unlike'
      expect(page).to_not have_button('Unlike')
      expect(page).to have_button('Like')
      expect(page).to have_text('0 likes')
    end
  end
end