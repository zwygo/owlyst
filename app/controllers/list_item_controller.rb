class ListItemController < ApplicationController

  def update_status
    liid = params[:liid]
    status = params[:status]
    li = ListItem.find(liid)
    render :json => {:error => "List item not found with id=#{params[:liid]}"} if li.nil?
    if li.update({:status => status})
      render :json => {:success => status}
    else
      render :json => {:error => "Unable to update status"}
    end
  end

end