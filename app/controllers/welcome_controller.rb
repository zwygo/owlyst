class WelcomeController < ApplicationController
  def index
    @count = User.count()
  end
end
