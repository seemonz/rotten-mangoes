class Admin::UsersController < ApplicationController
  # before_filter :authorize_admin

  def index
    @users = User.page(params[:page])

  end

  def new

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User changed"
    else
      render :edit
    end
  end

  def destroy
    if current_user.admin?
      @user = User.find(params[:id])
      @user.destroy
      UserMailer.delete_email(@user)
      redirect_to admin_users_path
    end
  end

private

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname)
  end


end
