class AddListTable < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :title
      t.string :user_id
      t.string :list_item_ids, array: true

      t.timestamps
    end
  end
end
