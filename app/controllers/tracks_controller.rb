class TracksController < ApplicationController
  before_action :set_track, only: [:show, :edit, :update, :destroy]

  # GET /tracks
  # GET /tracks.json
  def index
    @tracks = ActiveRecord::Base.connection.execute("SELECT * FROM tracks")
  end

  # GET /tracks/1
  # GET /tracks/1.json
  def show
    @track = ActiveRecord::Base.connection.execute("
      SELECT * 
      FROM tracks 
      WHERE tid = #{params[:id]} 
      LIMIT 1").first

    @games = ActiveRecord::Base.connection.execute("
      SELECT g.*
      FROM games g
      JOIN game_tracks gt
      ON g.gid = gt.gid
      WHERE tid = #{params[:id]}")

    respond_to do |format|
      format.html
      format.json {render json: Track.find(@track[0])}
    end
  end

  # GET /tracks/new
  def new
    @track = Track.new
  end

  # GET /tracks/1/edit
  def edit
  end

  # POST /tracks
  # POST /tracks.json
  def create
    @track = Track.new(track_params)

    respond_to do |format|
      if @track.valid?
        ActiveRecord::Base.connection.execute("
          INSERT INTO tracks (`tname`, `tinfo`, `tpictureurl`) 
          VALUES ('#{null_or_not(params[:track][:tname])}', 
            '#{null_or_not(params[:track][:tinfo])}',
            '#{null_or_not(params[:track][:tpictureurl])}');")

        id = Track.last.id

        ActiveRecord::Base.connection.execute("UPDATE tracks SET tid = #{id} WHERE id = #{id}")

        format.html { redirect_to @track, notice: 'Track was successfully created.' }
        format.json { render action: 'show', status: :created, location: @track }
      else
        format.html { render action: 'new' }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tracks/1
  # PATCH/PUT /tracks/1.json
  def update
    respond_to do |format|
      if @track.update(track_params)
        format.html { redirect_to @track, notice: 'Track was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tracks/1
  # DELETE /tracks/1.json
  def destroy
    @track.destroy
    respond_to do |format|
      format.html { redirect_to tracks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_track
      @track = Track.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def track_params
      params[:track].permit(:tname, :tinfo, :tpictureurl)
    end
end
