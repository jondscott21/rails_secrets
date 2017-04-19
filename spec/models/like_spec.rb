require 'rails_helper'
RSpec.describe Like, type: :model do
  describe 'relationships' do
    before do
      @user = create(:users)
      @secret = create(:secret, users: @user)
      @like = create(:like, users: @user, secret: @secret)
    end
    it 'belongs to a users' do
      expect(@like.user).to eq(@user)
    end
    it 'belongs to a secret' do
      expect(@like.secret).to eq(@secret)
    end
  end
end