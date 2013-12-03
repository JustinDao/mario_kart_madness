class KartsController < ApplicationController
  before_action :set_kart, only: [:show, :edit, :update, :destroy]

  # GET /karts
  # GET /karts.json
  def index
    @karts = ActiveRecord::Base.connection.execute("SELECT * FROM karts")
  end

  # GET /karts/1
  # GET /karts/1.json
  def show
    @kart = ActiveRecord::Base.connection.execute("
      SELECT * 
      FROM karts 
      WHERE kid = #{params[:id]} 
      LIMIT 1").first

    @games = ActiveRecord::Base.connection.execute("
      SELECT g.*
      FROM games g
      JOIN game_karts gk
      ON g.gid = gk.gid
      WHERE kid = #{params[:id]}")

    respond_to do |format|
      format.html
      format.json {render json: Kart.find(@kart[0])}
    end
  end

  # GET /karts/new
  def new
    @kart = Kart.new
  end

  # GET /karts/1/edit
  def edit
  end

  # POST /karts
  # POST /karts.json
  def create
    @kart = Kart.new(kart_params)

    respond_to do |format|
      if @kart.valid?
        ActiveRecord::Base.connection.execute("
          INSERT INTO karts (`kname`, `kinfo`, `kpictureurl`) 
          VALUES ('#{null_or_not(params[:kart][:kname])}', 
            '#{null_or_not(params[:kart][:kinfo])}',
            '#{null_or_not(params[:kart][:kpictureurl])}');")

        id = Kart.last.id

        ActiveRecord::Base.connection.execute("UPDATE karts SET kid = #{id} WHERE id = #{id}")

        format.html { redirect_to @kart, notice: 'Kart was successfully created.' }
        format.json { render action: 'show', status: :created, location: @kart }
      else
        format.html { render action: 'new' }
        format.json { render json: @kart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /karts/1
  # PATCH/PUT /karts/1.json
  def update
    respond_to do |format|
      if @kart.update(kart_params)
        format.html { redirect_to @kart, notice: 'Kart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @kart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /karts/1
  # DELETE /karts/1.json
  def destroy
    @kart.destroy
    respond_to do |format|
      format.html { redirect_to karts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kart
      @kart = Kart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kart_params
      params[:kart].permit(:kname, :kinfo, :kpictureurl)
    end
end
