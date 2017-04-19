class SessionsController < ApplicationController
  before_action :check_login, except: [:new, :create]
  def new
    # render login page
  end
  def create
    @user = User.find_by_email(params[:email])
    if @user and @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to "/users/#{@user.id}"
    else
      flash[:errors] = 'Invalid email or password'
      redirect_to '/sessions/new'
    end

  end
  def destroy
    session[:user_id] = nil
    redirect_to '/sessions/new'
  end
end
