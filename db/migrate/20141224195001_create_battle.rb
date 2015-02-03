class CreateBattle < ActiveRecord::Migration
  def change
  	create_table :battles do |t|
  		t.integer :current_target

  		t.timestamps	
  	end
  end
end
