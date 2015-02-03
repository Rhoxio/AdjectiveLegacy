class Enemy < ActiveRecord::Base

	def attack
		self.attack_rating + self.skill
	end

	def take_damage(hit)
		self.current_hp -= hit
		self.save!
	end

	def defend(assailant)
		dmg = (assailant.attack_rating + rand(1..assailant.level)) - self.defense
		if dmg - self.defense > 0
			self.take_damage(dmg)
			if self.dead? == true
				assailant.exp += self.exp
			end
		else
			self.take_damage(0)
		end
	end

	def enemy_gold
    self.gold = (self.level * 2) + rand(-2..5)
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
			if self.current_hp > self.max_hp
				diff = self.current_hp - self.max_hp
				self.current_hp = self.current_hp - diff
			end
		else
			return false
		end
	end

end