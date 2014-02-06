class SplashController < ApplicationController
  def index
    @count = User.count()
    @lists = []
    @lists = current_user.get_my_lists if current_user
  end

  def signup

  end

end