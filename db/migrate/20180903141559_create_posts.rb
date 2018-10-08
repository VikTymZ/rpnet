class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content

      t.integer :user_id
      t.string  :thumb_url
      t.string  :slug
      t.boolean :is_published
      t.timestamps
    end
  end
end
