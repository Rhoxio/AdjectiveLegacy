# I had all of my routes in a single file. Oh man was this confusing at first. I didn't
# realize that the environment actually loads all of the files in this folder at the time, so
# I decided to just write all of the routes in here to make sure it worked. 

get '/' do
  erb :title
end

post '/' do #Log In
	@user = User.find_by(email: params[:email])
	if @user == nil
		erb :error
	elsif @user.password == params[:password]
		session[:user_id] = @user.id
		redirect "/characters"
	elsif @user.password != params[:password]
		erb :error
	end
end

#-----------Guide-----------

get '/guide' do
	erb :guide
end

# ----------Signup----------
get '/signup' do
	erb :signup
end

post '/signup' do #Sign Up
  new_user = User.new(name: params[:name], email: params[:email])
  new_user.password = params[:password]
  new_user.save!
  redirect '/'
end


#---------Character--------
# The view for this did something like '@user.characters.each' and dynamically generated elements
# for each character. Great implementation. 
get '/characters' do
	@user = User.find(current_user)
	erb :character_select
end

# This post route is very sloppy. I could have just as easily
# called a method to generate those extra stats as opposed to
# manually having it all here. It would have kept the code so much 
# cleaner.
post '/characters' do
	@user = User.find(current_user)
	new_character = Character.create!(name: params[:name], player_class: params[:player_class], gender: params[:gender], level: 1, gold: 50, exp: 0, special:0, location: [0,0], max_hp: 50, current_hp: 50, skill: 1, attack_rating: 3, initiative: 5, defense: 1, weapon_id: 0, shield_id: 0, user_id: current_user, avatar: "/css/images/male_knight_transparent.png", headshot: "/css/images/headshots/male_knight_headshot.png" )
	assign_avatar(new_character)
	@user.characters << new_character
	@user.save!
	redirect "/characters"
end

# Look Ma, REST! Not really. This is just as sloppy, as I should have done something more like
# 'characters/:id/assign_current' or something. I relied on sessions, which
# isn'ta bad thing, but this limited the potential for multiple characters to be loggin in at one time.

# This actually led to problems down the road. Namely when I was trying to access specific characters down in the utility
# routes. There is a better esplanation toward the end of this file. 

post "/characters/:id" do
	@user = User.find(current_user)
	@user.current_character = params[:id]
	@user.save!
	redirect "/main"
end

delete "/characters/:id" do
	@user = User.find(current_user)
	@user.characters.destroy(params[:id])
	@user.current_character = 0
	redirect "/characters"
end


#-----------Main Hub--------

# Oh how I loved this navigation system. I had this idea to essentially assign a coordinate
# system to areas that I wanted to access in the game. This worked, but the only issue I had was that I
# didn't know how to check exact data structures against one another for some reason. So, when I
# created a new area, I would do something like '-1-1' for the coordinates as a string. Then, 
# I just used join here to get the right format to find the location that I wanted. 

get '/main' do
	@user = User.find(current_user)
	@character = active_character
	@location = Location.find_by(coordinates: active_character.location.join(''))
	@items = Item.all
	weapon_unlock?(@character, class_weapons(@character))
	if authorized? && @user.characters.count > 0
		@character = active_character
		erb :main_ui
	else
		erb :error
	end
end

put '/main/info' do 
	@user = User.find(current_user)
	@character = active_character
	@location = Location.find_by(coordinates: active_character.location.join(''))
	# return [@character.current_hp, @character.max_hp, @character.special, @character.exp, @character.next_level_exp].to_json
	return [@character, @character.next_level_exp].to_json
end

delete '/logout' do
	logout
	redirect '/'
end

# The actual navigation part of the routes. Depending on how you wanted to move, the coordinates would get
# changed on the character's model. I followed a standard x,y coordinate pattern for the cadinal directions.

# My main issue with this implementation is the need for a page refresh. I could jave AJAXed
# the whole thing, but I decided that it was basically the same as doing an entirely new page reresh and
# would make the loading of new stuff less clunky. 
put '/north' do
	@user = User.find(current_user)
	@character = active_character
	@location = Location.find_by(coordinates: active_character.location.join(''))
	@character.location_will_change!
	@character.location[1] += 1
	@character.save!
	redirect '/main'
end

put '/south' do
	@user = User.find(current_user)
	@character = active_character
	@location = Location.find_by(coordinates: active_character.location.join(''))
	@character.location_will_change!
	@character.location[1] -= 1
	@character.save!
	redirect '/main'
end

put '/west' do
	@user = User.find(current_user)
	@character = active_character
	@location = Location.find_by(coordinates: active_character.location.join(''))
	@character.location_will_change!
	@character.location[0] -= 1
	@character.save!
	redirect '/main'
end

put '/east' do
	@user = User.find(current_user)
	@character = active_character
	@location = Location.find_by(coordinates: active_character.location.join(''))
	@character.location_will_change!
	@character.location[0] += 1
	@character.save!
	redirect '/main'
end


#--------Combat-----------
# 'Queue the Decisive Battle Theme!'

# Really, though. The battle system was designed in a similar way to the location system.

# I didn't quite understand that you could pass data back in to the server easily yet, so I
# worked around it by essentially referencing the character with the active_character helper
# method located in battle.rb. Take a look at that code for a better explanation. 

get "/battle" do
	@user = User.find(current_user)
	@character = active_character
	@location = Location.find_by(coordinates: active_character.location.join(''))
	# enemy_spawn took the array from location.enemy_types and called .sample on it to give a single enemy object.
	# I was proud of it at the time, but I realize it is somewhat barbaric and not very descriptive. 
	@enemy = enemy_spawn(@location.enemy_types)
	# I did not generate new enemies every time. I just 'regenerated' the instance used from the last time. 
	@enemy.current_hp = @enemy.max_hp
	# Generates a gold amount on this instance of the enemy. 
	@enemy.enemy_gold
	@enemy.save!

	set_battle(@enemy.id)
	erb :battle_screen
end

get "/battle/:id" do
	@user = User.find(current_user)
	@character = active_character
	@location = Location.find_by(coordinates: active_character.location.join(''))
	@enemy = boss_spawn(params[:id])
	@enemy.current_hp = @enemy.max_hp
	@enemy.enemy_gold
	@enemy.save!

	set_battle(@enemy.id)
	erb :battle_screen
end

# I look back on this code in particular and can't help but laugh a little. 
# I didn't hash the response and ended up having to write comments about which object was in which
# index on the front-end. Now, I would have simply hashed it and called the attribute on the
# object that was parsed over. Like:

# {'enemy' => @enemy, 'character' => @character}.to_json

# Also, the special_handler method was easy to implement as it holds a check to see if the value goes below 0 or over 100. 
# It can take both positive and negative numbers. 

put "/battle/attack" do 
	@user = User.find(current_user)
	@character = active_character
	@enemy = Enemy.find(battle_id)

	@enemy.defend(@character)
	@character.special_handler(10)
	@character.save
	@enemy.save

	if @enemy.dead?
		return "win".to_json
	else
		return [@enemy, @character].to_json
	end
end

put "/battle/defend" do
	@user = User.find(current_user)
	@character = active_character
	@enemy = Enemy.find(battle_id)

	@character.defend(@enemy)
	@character.save

	if @character.dead?
		return "lose".to_json
	else
		# return [@character.current_hp, @character.max_hp].to_json
		return @character.to_json
	end
end

put "/battle/brace" do
	@user = User.find(current_user)
	@character = active_character
	@enemy = Enemy.find(battle_id)

	@character.defense += @character.level
	@character.defend(@enemy)
	@character.special_handler(5)
	@character.defense -= @character.level
	@character.save

	if @character.dead?
		return "lose".to_json
	else
		# return [@character.current_hp, @character.max_hp, @character.special].to_json
		return @character.to_json
	end
end

put "/battle/special" do 
	@user = User.find(current_user)
	@character = active_character
	@enemy = Enemy.find(battle_id)

	@character.special_boost
	@enemy.defend(@character)
	@enemy.save
	@character.special_handler(-100)
	@character.special_normalize

	if @enemy.dead?
		return "win".to_json
	else
		return [@enemy, @character].to_json
	end
end

put '/battle/run' do
	@user = User.find(current_user)
	@character = active_character
	@enemy = Enemy.find(battle_id)

	if run_success?
		return 'success'.to_json
	else
		return 'failure'.to_json
	end
end

put "/battle/win" do 
	@user = User.find(current_user)
	@character = active_character
	@enemy = Enemy.find(battle_id)

	@character.gain_exp(@enemy.exp)
	@character.heal(@character.max_hp/10)
	@character.acquire_currency(@enemy.gold)
	@character.level_up
	redirect "/main"
end

put "/battle/loss" do
	@user = User.find(current_user)
	@character = active_character
	@enemy = Enemy.find(battle_id)

	@character.current_hp = @character.max_hp
	@character.save
	redirect "/main"
end

# --------UTILITY---------



put "/heal" do
	@user = User.find(current_user)
	@character = active_character

	if @character.give_gold(10)
		@character.heal(@character.max_hp)
	else
		nil
	end
	return @character.to_json
end

# OH GOD THIS IS THE UNDRYEST CODE EVER

# I think I stopped caring about REST for a while.

# Should go something more like:

# get '/character/:id' do
# 	@character = Character.find(params[:id])
# 	return @character.to_json 
# end

put "/char" do
	@character = active_character
	return @character.to_json
end

put "/char/items" do
	@character = active_character
	# items = @character.items
	return @character.to_json
end

# Oh god. I have no idea what was going on here. It looks like
# the same route, but one saves and another doesn't. 

# Also, the page 'refresh' should technically be unnecessary if I was using
# AJAX correctly. 

put "/equip/:id" do
	@character = active_character
	@character.equip_weapon(@character.items.find(params[:id]))
	redirect "/main"
end

put '/equip_weapon/:id' do 
	@character = active_character
	@character.equip_weapon(@character.items.find(params[:id]))
	@character.save
	redirect '/main'
end

# So unRESTful. It hurts my eyes...

put '/unequip_weapon' do
	@character = active_character
	@character.unequip_weapon(@character.weapon_id)
	@character.save
	redirect '/main'
end

# For cases where I wanted to reset their position back to the main city. Primarily
# used when they enter an area under development. 

# Again, not restful and relies on the session as most of this did. 

put '/reset_position' do
	@character = active_character
	@character.location = [0,0]
	@character.save
	redirect '/main'
end

# before '/route' do
# 	stuff
# end

 







