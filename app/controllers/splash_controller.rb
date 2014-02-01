class SplashController < ApplicationController
  def index
    @count = User.count()
  end

  def signup

  end

end