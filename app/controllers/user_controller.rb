class UserController < ApplicationController

  def create_from_email
    user_params = {
      :name => params[:name],
      :email => params[:email],
      :password => params[:password],
      :password_confirmation => params[:password_confirmation]
    }
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url
    else
      puts @user.errors.full_messages
      redirect_to "splash/signup"
    end
  end
end
