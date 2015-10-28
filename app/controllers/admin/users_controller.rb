class Admin::UsersController < ApplicationController
  before_filter :authorize_admin

  def index
    @users = User.all
  end

  def new 
    
  end

end

