class CreateItems < ActiveRecord::Migration[4.2]
  def change
  	create_table :items do |t|
  		t.string :name
  		t.string :description
  		t.integer :value

  		t.string :item_type
  		t.string :item_effect

  		t.integer :attack_modifier
  		t.integer :defense_modifier

  		t.integer :character_id
      t.integer :count

  		t.timestamps
  	end
  end
end
