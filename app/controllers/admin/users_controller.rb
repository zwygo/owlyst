class Admin::UsersController < ApplicationController

  def index
    @users = User.all()
  end

  def create

  end

  def new

  end

end
