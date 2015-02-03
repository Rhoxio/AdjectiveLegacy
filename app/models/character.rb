class Character < ActiveRecord::Base
	
	belongs_to :user
	has_many :items

	def level_up
	level_table = {1 => 10, 2 => 50, 3 => 100, 4 => 175, 5 => 260, 6 => 365, 7 => 480, 8 => 630, 9 => 830, 10 => 1010}

		if self.exp >= level_table[self.level]
			self.exp = self.exp - level_table[self.level]
			self.level += 1
			self.max_hp += 20
			self.defense += 1
			self.initiative += 1
			self.attack_rating += 2
			self.current_hp = self.max_hp
			self.save!
			return true
		else
			return false
		end
	end

	# Actually takes Items right now...
	def equip_weapon(id)
		if self.weapon_id == 0
			weapon = Item.find(id)
			self.weapon_id = weapon.id
			self.attack_rating += weapon.attack_modifier
		else
			return false
		end
	end

	def unequip_weapon(id)
		weapon = Item.find(id)
		self.weapon_id = 0
		self.attack_rating -= weapon.attack_modifier
	end

	def give_gold(amount)
		if self.gold >= amount
			self.gold -= amount
		end
	end

	def next_level_exp
		level_table = {1 => 10, 2 => 50, 3 => 100, 4 => 175, 5 => 260, 6 => 365, 7 => 480, 8 => 630, 9 => 830, 10 => 1010}
		level_table[self.level]
	end

	def exp_to_next_level
		level_table = {1 => 10, 2 => 50, 3 => 100, 4 => 175, 5 => 260, 6 => 365, 7 => 480, 8 => 630, 9 => 830, 10 => 1010}
		level_table[self.level] - self.exp 
	end

	def gain_exp(exp_gain)
		self.exp += exp_gain
		self.save!
	end


	def acquire_currency(amount)
		self.gold += amount
		self.save!
	end

	def attack
		self.attack_rating + self.skill
	end

	def take_damage(hit)
		self.current_hp -= hit
		self.save!
	end

	def defend(assailant)
		dmg = (assailant.attack_rating + rand(1..assailant.level)) - self.defense
		if dmg > 0
			self.take_damage(dmg)
		else
			self.take_damage(0)
		end
	end

	def dead?
		if self.current_hp <= 0
			return true
		else
			return false
		end
	end

	def phoenix
		if self.current_hp <= 0
			self.current_hp = 1
		end
	end

	def heal(healing)
		if self.dead? == false
			self.current_hp += healing
			self.save!
			if self.current_hp > self.max_hp
				diff = self.current_hp - self.max_hp
				self.current_hp = self.current_hp - diff
				self.save!
			end

		return self.current_hp
		else
			return false
		end
	end

	def located?
		self.location
	end

	def special_handler(input)
		self.special += input
			if self.special > 100
				self.special -= self.special - 100
			end
		self.save!
	end

	def special_boost
		if self.player_class == "paladin"
			self.attack_rating = self.attack_rating * 3
		elsif self.player_class == "ranger"
			self.attack_rating = self.attack_rating * 3
		elsif self.player_class == "thief"
			self.attack_rating = self.attack_rating * 4
		elsif self.player_class == "mage"
			self.attack_rating = self.attack_rating * 5
		end
		self.save!
	end

	def special_normalize
		if self.player_class == "paladin"
			self.attack_rating = self.attack_rating / 3
		elsif self.player_class == "ranger"
			self.attack_rating = self.attack_rating / 3
		elsif self.player_class == "thief"
			self.attack_rating = self.attack_rating / 4
		elsif self.player_class == "mage"
			self.attack_rating = self.attack_rating / 5
		end
		self.save!
	end

end