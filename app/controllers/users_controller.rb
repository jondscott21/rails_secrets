class UsersController < ApplicationController
  before_action :check_login, except: [:new, :create]
  before_action :match_params, only: [:show, :edit, :update, :destroy]
  def new
  end

  def show
    @user = User.find(params[:id])
  end
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to '/sessions/new'
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to '/users/new'
    end
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to "/users/#{@user.id}"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_back(fallback_location: :back)
    end
  end
  def destroy
    session[:user_id] = nil
    user = User.find(params[:id])
    user.destroy
    redirect_to '/users/new'
  end
  private
  def user_params
    params.require(:users).permit(:name, :email, :password, :password_confirmation)
  end
  def match_params
    if current_user != User.find(params[:id])
      redirect_to "/users/#{session[:user_id]}"
    end
  end
end