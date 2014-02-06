class ListController < ApplicationController

  def create
    render :json => {:error => "No user"} and return if current_user.nil?
    title = params[:title]
    list_params = {
      :user_id => current_user.id,
      :title => title,
      :list_item_ids => []
    }
    list = List.new(list_params)
    if list.save
      params[:items].each do |item|
        title = item
        list.add_item(current_user.id, title, "")
      end
      render :json => {:list => list}
    else
      render :json => {:error => @user.errors.full_messages}
    end
  end

  def destroy
    lid = params[:lid]
    if List.destroy(lid)
      render :json => {:lid => lid}
    else
      render :json => {:error => "Did not delete"}
    end
  end

end