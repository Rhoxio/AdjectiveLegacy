class CreateLocations < ActiveRecord::Migration
  def change
  	create_table :locations do |t|
  		t.string :name
  		t.string :js_view
  		t.string :js_controller
  		t.string :js_battle
  		t.string :battle_background
  		t.integer :enemy_types, :array => true
  		t.string :coordinates
  end
end
end
