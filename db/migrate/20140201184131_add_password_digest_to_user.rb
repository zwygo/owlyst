class AddPasswordDigestToUser < ActiveRecord::Migration
  def change
    add_column :users, :permission, :integer
    add_column :users, :password_digest, :string
    remove_column :users, :password_hash, :string
    remove_column :users, :password_salt, :string
  end
end
