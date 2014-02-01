class ListController < ApplicationController

  def create
    render :json => {:error => "No user"} if current_user.nil?
    title = params[:title]
    list_params = {
      :user_id => current_user.id,
      :title => tiele
    }
    list = List.new(list_params)
    if list.save
      params[:items].each do |item|
        title = item
        list.add_item(title, "")
      end
      render :json => {:list => list}
      redirect_to root_url
    else
      render :json => {:error => @user.errors.full_messages}
    end
  end

end