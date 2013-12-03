class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = ActiveRecord::Base.connection.execute("SELECT * FROM users")
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = ActiveRecord::Base.connection.execute("
      SELECT * 
      FROM users 
      WHERE username = '#{params[:username].downcase}' 
      LIMIT 1").first

    respond_to do |format|
      format.html
      format.json {render json: User.find(@user[0])}
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    check = user_params

    username = params[:user][:username].downcase
    password = params[:user][:password]
    password_confirmation = params[:user][:password_confirmation]

    @user = User.new(:username => username, :password => password)

    temp_user = ActiveRecord::Base.connection.execute("
      SELECT * 
      FROM users 
      WHERE username = '#{username}'
      LIMIT 1").first
    
    respond_to do |format|
      if password.length > 0 && username.length > 0 && password == password_confirmation && @user.valid? && temp_user == nil
        password = Digest::MD5.hexdigest(password)
        ActiveRecord::Base.connection.execute("
          INSERT INTO users (`username`, `password`) 
          VALUES ('#{null_or_not(username)}', 
            '#{null_or_not(password)}');")

        user = ActiveRecord::Base.connection.execute("
          SELECT * 
          FROM users 
          WHERE username = '#{username}'
          LIMIT 1").first

        sign_in user

        format.html { redirect_to root_path, notice: 'User was successfully created.' }
      else
        format.html { redirect_to sign_up_path, notice: 'User was not created.' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params[:user].permit(:username, :password, :password_confirmation)
    end
end
