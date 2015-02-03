helpers do

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

  def set_battle(input)
    battle = Battle.find(1)
    battle.update(current_target: input)
    battle.save
  end

  def battle_id
    battle = Battle.find(1).current_target
  end

  def active_character
    user = User.find(current_user)
    user.characters.find(user.current_character)
  end

  def run_success?
    roll = rand(1..100)
    if roll > 60
      return true
    else
      return false
    end
  end



end