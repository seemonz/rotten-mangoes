class Admin::UsersController < ApplicationController
  # before_filter :authorize_admin

  def index
    @users = User.page(params[:page])

  end

  def new 
    
  end

  def destroy
    if current_user.admin?
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_users_path
    end
  end



end

