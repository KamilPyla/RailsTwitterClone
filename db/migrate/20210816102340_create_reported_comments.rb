class CreateReportedComments < ActiveRecord::Migration[6.1]
  def change
    create_table :reported_comments do |t|
      t.text :content
      t.references :micropost, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
