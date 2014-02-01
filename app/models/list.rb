class List < ActiveRecord::Base

  def add_item(title, text)
    raise 'No user' if current_user.nil?
    item_params = {
      :title => title,
      :text => text,
      :user_id => current_user.id,
      :list_id => self.id,
      :status => ""
    }
    item = ListItem.new(item_params)
    if item.save
      self.list_item_ids.push(item.id)
    else
      raise 'Unable to add item #{title}'
    end
  end

end