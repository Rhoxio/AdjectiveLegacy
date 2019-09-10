class CreateUsers < ActiveRecord::Migration[4.2]
  def change 
  	create_table :users do |t|
  		t.string :name
  		t.string :email
  		t.string :password_hash

  		t.integer :current_character

  		t.timestamps
  	end
  end
end
