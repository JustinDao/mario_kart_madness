class ConsolesController < ApplicationController
  before_action :set_console, only: [:show, :edit, :update, :destroy]

  # GET /consoles
  # GET /consoles.json
  def index
    @consoles = ActiveRecord::Base.connection.execute("SELECT * FROM consoles")
  end

  # GET /consoles/1
  # GET /consoles/1.json
  def show
    @console = ActiveRecord::Base.connection.execute("
      SELECT * 
      FROM consoles 
      WHERE gcid = #{params[:id]} 
      LIMIT 1").first

    @games = ActiveRecord::Base.connection.execute("
      SELECT g.*
      FROM games g
      JOIN console_games cg
      ON g.gid = cg.gid
      WHERE gcid = #{params[:id]}")

    respond_to do |format|
      format.html
      format.json {render json: Console.find(@console[0])}
    end
  end

  # GET /consoles/new
  def new
    @console = Console.new
  end

  # GET /consoles/1/edit
  def edit
  end

  # POST /consoles
  # POST /consoles.json
  def create
    @console = Console.new(console_params)

    respond_to do |format|
      if @console.valid?
        ActiveRecord::Base.connection.execute("
          INSERT INTO consoles (`gcname`,`gcinfo`,`gcpictureurl`) 
          VALUES ('#{null_or_not(params[:console][:gcname])}', 
            '#{null_or_not(params[:console][:gcinfo])}',
            '#{null_or_not(params[:console][:gcpictureurl])}');")

        id = Console.last.id

        ActiveRecord::Base.connection.execute("UPDATE consoles SET gcid = #{id} WHERE id = #{id}")

        format.html { redirect_to @console, notice: 'Console was successfully created.' }
        format.json { render action: 'show', status: :created, location: @console }
      else
        format.html { render action: 'new' }
        format.json { render json: @console.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /consoles/1
  # PATCH/PUT /consoles/1.json
  def update
    respond_to do |format|
      if @console.update(console_params)
        format.html { redirect_to @console, notice: 'Console was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @console.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /consoles/1
  # DELETE /consoles/1.json
  def destroy
    @console.destroy
    respond_to do |format|
      format.html { redirect_to consoles_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_console
      @console = Console.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def console_params
      params[:console].permit(:gcname, :gcinfo, :gcpictureurl)
    end
end
