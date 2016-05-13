class AddGroupToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :group, :integer, null: false, default: 0
  end
end
