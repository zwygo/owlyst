class List < ActiveRecord::Base
  after_destroy :destroy_list_items

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
      self.update({:list_item_ids => self.list_item_ids + [item.id]})
    else
      raise 'Unable to add item #{title}'
    end
  end

  def destroy_list_items
    ListItem.destroy_all(:list_id => self.id.to_s)
  end

end