class SearchController < ApplicationController
  def search
    
  end

  def find
    query = params[:query]

    results = []

    tracks = ActiveRecord::Base.connection.execute("
      SELECT * 
      FROM `tracks` 
      WHERE tname LIKE '#{query}%'").to_a

    tracks.each do |track|
      results.push([track[get_field_index(Track, "tname")],track_path(track[0])])
    end

    games = ActiveRecord::Base.connection.execute("
      SELECT * 
      FROM `games`
      WHERE gname LIKE '#{query}%'").to_a

    games.each do |game|
      results.push([game[get_field_index(Game, "gname")],game_path(game[0])])
    end

    consoles = ActiveRecord::Base.connection.execute("
      SELECT * 
      FROM `consoles`
      WHERE gcname LIKE '#{query}%'").to_a

    consoles.each do |console|
      results.push([console[get_field_index(Console, "gcname")],console_path(console[0])])
    end

    items = ActiveRecord::Base.connection.execute("
      SELECT * 
      FROM `items`
      WHERE iname LIKE '#{query}%'").to_a

    items.each do |item|
      results.push([item[get_field_index(Item, "iname")],item_path(item[0])])
    end

    characters = ActiveRecord::Base.connection.execute("
      SELECT * 
      FROM `characters`
      WHERE cname LIKE '#{query}%'").to_a

    characters.each do |character|
      results.push([character[get_field_index(Character, "cname")],character_path(character[0])])
    end

    respond_to do |format|
      format.json {render json: results}
    end
  end
end