
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

get '/characters' do
	@user = User.find(current_user)
	erb :character_select
end

post '/characters' do
	@user = User.find(current_user)
	new_character = Character.create!(name: params[:name], player_class: params[:player_class], gender: params[:gender], level: 1, gold: 50, exp: 0, special:0, location: [0,0], max_hp: 50, current_hp: 50, skill: 1, attack_rating: 3, initiative: 5, defense: 1, weapon_id: 0, shield_id: 0, user_id: current_user, avatar: "/css/images/male_knight_transparent.png", headshot: "/css/images/headshots/male_knight_headshot.png" )
	assign_avatar(new_character)
	@user.characters << new_character
	@user.save!
	redirect "/characters"
end

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

get "/battle" do
	@user = User.find(current_user)
	@character = active_character
	@location = Location.find_by(coordinates: active_character.location.join(''))
	@enemy = enemy_spawn(@location.enemy_types)
	@enemy.current_hp = @enemy.max_hp
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

put "/char" do
	@character = active_character
	return @character.to_json
end

put "/char/items" do
	@character = active_character
	# items = @character.items
	return @character.to_json
end

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

put '/unequip_weapon' do
	@character = active_character
	@character.unequip_weapon(@character.weapon_id)
	@character.save
	redirect '/main'
end

put '/reset_position' do
	@character = active_character
	@character.location = [0,0]
	@character.save
	redirect '/main'
end

# before '/route' do
# 	stuff
# end

 






