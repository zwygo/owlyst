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

  def reorder_items
    newOrder = params[:order]
    list = List.find(params[:lid])
    render :json => {:error => "List not found with id=#{params[:lid]}"} if list.nil?
    if list.reorder(newOrder)
      render :json => {:success => newOrder}
    else
      render :json => {:error => "Unable to reorder list"}
    end
  end

end