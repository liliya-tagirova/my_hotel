class SessionsController < ApplicationController

  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: :destroy



  def edit

  end


  def update

  end

  def new
  end


  def create
    render plain: params.to_yaml and return
    user = User.find_by email: params[:email]
    if user&.authenticate(params[:password])
      sign_in user
      flash[:success] = "Welcome back, #{current_user.name}"
      redirect_to root_path
    else
      flash[:warning] = "Incorrect email and/or password!"
      render :new
    end
  end


  def destroy
    sign_out
    flash[:success] = "See you later!"
    redirect_to root_path
  end


  private

  def set_user!
    @user = User.find params[:id]
  end


end