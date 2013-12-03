module SessionsHelper
  def sign_in(user)
    cookies.permanent[:user] = user[1]
    cookies.permanent[:password] = user[2]
    current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = User.find_by(:username => user[1], :password => user[2])
  end

  def current_user
    @current_user ||= User.find_by(:username => cookies[:user], :password => cookies[:password])
  end

  def sign_out
    cookies.permanent[:user] = nil
    cookies.permanent[:password] = nil
    current_user = nil
  end
end