require 'rails_helper'
RSpec.describe SecretsController, type: :controller do
  before do
    @user = create(:users)
    @secret = create(:secret, users: @user)
  end
  context "when not logged in" do
    before do
      session[:user_id] = nil
    end
    it "cannot access index" do
      get :index
      expect(response).to redirect_to("/sessions/new")
    end
    it "cannot access create" do
      post :create, params: {id: @user.id}
      expect(response).to redirect_to("/sessions/new")
    end
    it "cannot access destroy" do
      delete :destroy, params: {id: @user.id}
      expect(response).to redirect_to("/sessions/new")
    end
  end
end