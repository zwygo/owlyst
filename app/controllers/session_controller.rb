class SessionController < ApplicationController
  def new

  end

  def create_by_email
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render :json => { :success => "success"}
    else
      render :json => {:error => "Incorrect email / password"}
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end