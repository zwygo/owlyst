class User < ActiveRecord::Base
  has_secure_password

  validates_uniqueness_of :email

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.name
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def get_my_lists
    list_items = {}
    ListItem.where(:user_id => self.id.to_s).each do |li|
      list_items[li.id.to_s] = {
        "liid" => li.id,
        "lid" => li.list_id,
        "title" => li.title,
        "text" => li.text,
        "status" => li.status
      }
    end
    lists = []
    List.where(:user_id => self.id.to_s).each do |l|
      list_order = l['list_item_ids']
      items = []
      puts list_order
      list_order.each{|lo| items.push(list_items[lo])}
      lists.push({
        "lid" => l.id,
        "list_items" => items,
        "title" => l.title,
        "created_at" => l.created_at
      })
    end
    return lists
  end
end