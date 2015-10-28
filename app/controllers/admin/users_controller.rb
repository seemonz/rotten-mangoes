class Admin::UsersController < ApplicationController
  # before_filter :authorize_admin

  def index
    p "a big hello"
    #@users = User.order(:email).page(params[:page]).per(2).includes(:email)
    @users = User.page(params[:page])
    p @users.count

  end

  def new 
    
  end

end

