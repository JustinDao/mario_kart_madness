class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = ActiveRecord::Base.connection.execute("SELECT * FROM games")
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game = ActiveRecord::Base.connection.execute("
      SELECT * 
      FROM games 
      WHERE gid = #{params[:id]} 
      LIMIT 1").first

    @characters = ActiveRecord::Base.connection.execute("
      SELECT c.*
      FROM characters c
      JOIN game_characters g 
      ON g.cid = c.cid
      WHERE gid = #{params[:id]}")

    @items = ActiveRecord::Base.connection.execute("
      SELECT i.*
      FROM items i
      JOIN game_items g 
      ON i.iid = g.iid
      WHERE gid = #{params[:id]}")

    @tracks = ActiveRecord::Base.connection.execute("
      SELECT t.*
      FROM tracks t
      JOIN game_tracks gt 
      ON t.tid = gt.tid
      WHERE gid = #{params[:id]}")

    @karts = ActiveRecord::Base.connection.execute("
      SELECT k.*
      FROM karts k
      JOIN game_karts gk 
      ON k.kid = gk.kid
      WHERE gid = #{params[:id]}")

    @console = ActiveRecord::Base.connection.execute("
      SELECT gc.*
      FROM consoles gc
      JOIN console_games cg 
      ON gc.gcid = cg.gcid
      WHERE gid = #{params[:id]}
      LIMIT 1").first

    respond_to do |format|
      format.html
      format.json {render json: Game.find(@game[0])}
    end
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.valid?
        ActiveRecord::Base.connection.execute("
          INSERT INTO games (`gname`, `greleasedate`, `ginfo`, `gpictureurl`) 
          VALUES ('#{null_or_not(params[:game][:gname])}', 
            #{null_or_not(params[:game][:greleasedate])}, 
            '#{null_or_not(params[:game][:ginfo])}',
            '#{null_or_not(params[:game][:gpictureurl])}');")

        id = Game.last.id

        ActiveRecord::Base.connection.execute("UPDATE games SET gid = #{id} WHERE id = #{id}")

        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render action: 'show', status: :created, location: @game }
      else
        format.html { render action: 'new' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params[:game].permit(:gname, :greleasedate, :ginfo, :gpictureurl)
    end
end
