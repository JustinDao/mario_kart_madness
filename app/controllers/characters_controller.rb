class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :edit, :update, :destroy]

  # GET /characters
  # GET /characters.json
  def index
    @characters = ActiveRecord::Base.connection.execute("SELECT * FROM characters")
  end

  # GET /characters/1
  # GET /characters/1.json
  def show
    @character = ActiveRecord::Base.connection.execute("
      SELECT * 
      FROM characters 
      WHERE cid = #{params[:id]} 
      LIMIT 1").first

    @games = ActiveRecord::Base.connection.execute("
      SELECT g.*
      FROM games g
      JOIN game_characters gc
      ON g.gid = gc.gid
      WHERE cid = #{params[:id]}")

    respond_to do |format|
      format.html
      format.json {render json: Character.find(@character[0])}
    end
  end

  # GET /characters/new
  def new
    @character = Character.new
  end

  # GET /characters/1/edit
  def edit
  end

  # POST /characters
  # POST /characters.json
  def create
    @character = Character.new(character_params)

    respond_to do |format|
      if @character.valid?
        ActiveRecord::Base.connection.execute("
          INSERT INTO characters (`gname`, `greleasedate`, `ginfo`, `gpictureurl`) 
          VALUES ('#{null_or_not(params[:character][:cname])}', 
            '#{null_or_not(params[:character][:cinfo])}',
            '#{null_or_not(params[:character][:cpictureurl])}');")

        id = Character.last.id

        ActiveRecord::Base.connection.execute("UPDATE characters SET cid = #{id} WHERE id = #{id}")

        format.html { redirect_to @character, notice: 'Character was successfully created.' }
        format.json { render action: 'show', status: :created, location: @character }
      else
        format.html { render action: 'new' }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /characters/1
  # PATCH/PUT /characters/1.json
  def update
    respond_to do |format|
      if @character.update(character_params)
        format.html { redirect_to @character, notice: 'Character was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /characters/1
  # DELETE /characters/1.json
  def destroy
    @character.destroy
    respond_to do |format|
      format.html { redirect_to characters_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character
      @character = Character.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def character_params
      params[:character].permit(:cname, :cinfo, :cpictureurl)
    end
end
