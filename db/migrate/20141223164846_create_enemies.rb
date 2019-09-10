class CreateEnemies < ActiveRecord::Migration[4.2]
  def change
  	create_table :enemies do |t|
  	t.string :name
  	t.string :enemy_class
    t.string :avatar

  	t.integer :level
  	t.integer :exp

    t.integer :max_hp
    t.integer :current_hp
     
    t.integer :skill

    t.integer :attack_rating
    t.integer :initiative
    t.integer :defense

    t.integer :gold

  	t.timestamps
  	end
  end
end
