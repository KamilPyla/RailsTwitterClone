class AddBlockToMicroposts < ActiveRecord::Migration[6.1]
  def change
    add_column :microposts, :blocked, :boolean
    add_column :microposts, :reported, :boolean
  end
end
