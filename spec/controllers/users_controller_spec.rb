require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  before do
    @user = create(:users)
  end
  context "when not logged in" do
    before do
      session[:user_id] = nil
    end
    it "cannot access show" do
      get :show, params: {id: @user.id}
      expect(response).to redirect_to("/sessions/new")
    end
    it "cannot access edit" do
      get :edit, params: {id: @user.id}
      expect(response).to redirect_to("/sessions/new")
    end
    it "cannot access update" do
      put :update, params: {id: @user.id}
      expect(response).to redirect_to("/sessions/new")
    end
    it "cannot access destroy" do
      delete :destroy, params: {id: @user.id}
      expect(response).to redirect_to("/sessions/new")
    end
  end
end