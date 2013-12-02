class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items = ActiveRecord::Base.connection.execute("SELECT * FROM items")
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = ActiveRecord::Base.connection.execute("
      SELECT * 
      FROM items 
      WHERE iid = #{params[:id]} 
      LIMIT 1").first

    @games = ActiveRecord::Base.connection.execute("
      SELECT g.*
      FROM games g
      JOIN game_items gi
      ON g.gid = gi.gid
      WHERE iid = #{params[:id]}")

    respond_to do |format|
      format.html
      format.json {render json: Item.find(@item[0])}
    end
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.valid?
        ActiveRecord::Base.connection.execute("
          INSERT INTO items (`iname`, `iinfo`, `ipictureurl`) 
          VALUES ('#{null_or_not(params[:item][:iname])}', 
            '#{null_or_not(params[:item][:iinfo])}',
            '#{null_or_not(params[:item][:ipictureurl])}');")

        id = Item.last.id

        ActiveRecord::Base.connection.execute("UPDATE items SET iid = #{id} WHERE id = #{id}")

        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @item }
      else
        format.html { render action: 'new' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params[:item].permit(:iname, :iinfo, :ipictureurl)
    end
end
