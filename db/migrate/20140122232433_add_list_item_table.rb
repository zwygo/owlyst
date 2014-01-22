class AddListItemTable < ActiveRecord::Migration
  def change
    create_table :list_items do |t|
      t.string :list_id
      t.string :user_id
      t.string :title
      t.text   :text
      t.string :status

      t.timestamps
    end
  end
end
