class CreateUser < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :pass
      t.string :uname

      t.string :first_name
      t.string :last_name
      t.text   :bio

      t.string :pic_url

      t.integer :role
    end
  end
end
