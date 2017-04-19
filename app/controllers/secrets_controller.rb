class SecretsController < ApplicationController
  before_action :check_login
  def index
    @secrets = Secret.all
  end
  def create
    secret = Secret.new(secret_params)
    if secret.save
      redirect_back(fallback_location: :back)
    else
      flash[:errors] = secret.errors.full_messages
      redirect_back(fallback_location: :back)
    end
  end
  def destroy
    @secret = Secret.find(params[:id])
    @secret.destroy if @secret.user == current_user
    redirect_to "/users/#{@secret.user.id}"
  end
  private
  def secret_params
    params.require(:secret).permit(:content).merge(users: current_user)
  end
end
