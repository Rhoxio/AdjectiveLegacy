helpers do 

	def assign_avatar(character)
		if character.player_class == "paladin"
			if character.gender == "male"
				character.avatar = "/css/images/male_knight_transparent.png"
				character.headshot = "/css/images/headshots/male_knight_headshot.png"
			elsif character.gender == "female"
				character.avatar = "/css/images/female_knight_transparent.png"
				character.headshot = "/css/images/headshots/female_knight_headshot.png"
			end

		elsif character.player_class == "thief"
			if character.gender == "male"
				character.avatar = "/css/images/male_knight_transparent.png"
				character.headshot = "/css/images/headshots/male_knight_headshot.png"
			elsif character.gender == "female"
				character.avatar = "/css/images/female_thief_transparency.png"
				character.headshot = "/css/images/headshots/female_thief_headshot.png"
			end

		elsif character.player_class == "ranger"
			if character.gender == "male"
				character.avatar = "/css/images/male_ranger_transparent.png"
				character.headshot = "/css/images/headshots/male_ranger_headshot.png"
			elsif character.gender == "female"
				character.avatar = "/css/images/female_ranger_transparent.png"
				character.headshot = "/css/images/headshots/female_ranger_headshot.png"
			end

		elsif character.player_class == "mage"
			if character.gender == "male"
				character.avatar = "/css/images/male_knight_transparent.png"
				character.headshot = "/css/images/headshots/male_knight_headshot.png"
			elsif character.gender == "female"
				character.avatar = "/css/images/female_knight_transparent.png"
				character.headshot = "/css/images/headshots/female_knight_headshot.png"
			end
		end
		character.save!
	end

	def fruit_of_knowledge(character)
		Item.all.each do |item|
			item.count = 0
			character.items << item
		end
		character.save!
	end

	def class_weapons(character)
		if character.player_class == "paladin"
			weapon_array = [1,5,9]
		elsif character.player_class =="ranger"
			weapon_array = [2,6,10]
		elsif character.player_class == "thief"
			weapon_array = [3,7,11]
		elsif character.player_class == "mage"
			weapon_array = [4,8,12]
		end
		return weapon_array
	end

	def weapon_unlock?(character, class_weapons)
		current_items = []

		character.items.each do |item|
			current_items << item.id
		end
		 p current_items
		 p class_weapons[0]
		if character.level == 3
			puts "hitting 3"
				character.items << Item.find(class_weapons[0])
		elsif character.level == 6
			puts "hitting 6"
				character.items << Item.find(class_weapons[1])
		elsif character.level == 9 
				character.items << Item.find(class_weapons[2])
		else
			puts "hitting false"
			return false
		end
	end

	def equipped_weapon(character)
		if character.weapon_id != 0
			return Item.find(character.weapon_id).name
		else
			return "None"
		end
	end

end






