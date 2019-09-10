class CreateBattle < ActiveRecord::Migration[4.2]
  def change
  	create_table :battles do |t|
  		t.integer :current_target

  		t.timestamps	
  	end
  end
end
