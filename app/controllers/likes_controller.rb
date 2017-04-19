class LikesController < ApplicationController
  before_action :check_login
  def create
    like = Like.new(like_params)
    if like.save
      redirect_back(fallback_location: :back)
    else
      flash[:error] = "You can't like this"
    end
  end

  def destroy
   like = Like.find(params[:id])
   like.destroy if current_user == like.user
   redirect_back(fallback_location: :back)
  end
  private
  def like_params
    params.require(:like).permit(:secret_id).merge(users: current_user)
  end
end
