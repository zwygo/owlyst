class List < ActiveRecord::Base

  def add_item(user_id, title, text)
    item_params = {
      :title => title,
      :text => text,
      :user_id => user_id,
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