helpers do

# Lots of these rely on implicit returns. Probably a bad idea, but it works.
  def enemy_spawn(array_of_ids)
    enemy1 = Enemy.find(array_of_ids.sample)
  end

  def boss_spawn(id)
    enemy1 = Enemy.find(id)
  end

  def current_user
    session[:user_id]
  end

  def current_enemy
    cookies[:enemy_id]
  end

# I had to make a table to persist the battle data. I could have used the session hash or something,
# but I didn't think of it at the time. This worked fine, though. Not a clean implementation as
# it requires more database lookups. 

  def set_battle(input)
    battle = Battle.find(1)
    battle.update(current_target: input)
    battle.save
  end

  def battle_id
    battle = Battle.find(1).current_target
  end

# I ended up setting the current_character attribute on a user when they logged in to a character.
# Whenever I needed to see which character they were on, it was nice to just
# call this method as opposed to having to write this logic every single time.
# It relies on a session being active, which may be a good thing.

  def active_character
    user = User.find(current_user)
    user.characters.find(user.current_character)
  end

# Basically had to hard-code some luck in here. 40% chance to successfully run, essentially. 
  def run_success?
    roll = rand(1..100)
    if roll > 60
      return true
    else
      return false
    end
  end



end