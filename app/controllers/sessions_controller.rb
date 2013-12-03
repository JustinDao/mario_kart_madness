class SessionsController < ApplicationController
  def new
  end

  def create
    password = Digest::MD5.hexdigest(params[:session][:password].gsub("'", %q(\\\')))
    username = params[:session][:username].downcase.gsub("'", %q(\\\'))

    user = ActiveRecord::Base.connection.execute("
      SELECT * 
      FROM users 
      WHERE username = '#{username}'
      AND password = '#{password}'
      LIMIT 1").to_a.first

    if user != nil
      sign_in user
      redirect_to root_path
    else
      respond_to do |format|
        format.html { redirect_to login_path, notice: 'Invalid username/password combination'}
      end
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
