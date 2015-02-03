helpers do

  def logout
    session.clear
    redirect_home
  end

  def authorized?
    !!session[:user_id]
  end

  def redirect_home
    redirect '/'
  end

  def current_user
    session[:user_id]
  end
  
end