class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name_en
      t.string :name_pl
      t.string :name_it
      t.string :name_cn

      t.timestamps
    end
  end
end
