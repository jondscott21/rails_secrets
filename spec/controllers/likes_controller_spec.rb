require 'rails_helper'
RSpec.describe LikesController, type: :controller do
  before do
    @user = create(:users)
    @secret = create(:secret, users: @user)
    @like = create(:like, secret: @secret, users: @user)
  end
  context "when not logged in " do
    before do
      session[:user_id] = nil
    end
    it "cannot create a like" do
      post :create
      expect(response).to redirect_to("/sessions/new")
    end
    it "cannot destroy a like" do
      delete :destroy, params: {id: @user.id}
      expect(response).to redirect_to("/sessions/new")
    end
  end
end