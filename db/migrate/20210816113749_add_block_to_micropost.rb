class AddBlockToMicropost < ActiveRecord::Migration[6.1]
  def change
    add_column :microposts, :blocked, :boolean, default: false
    add_column :microposts, :reported, :boolean, default: false
  end
end
