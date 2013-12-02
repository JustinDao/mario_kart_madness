class SearchController < ApplicationController
  def search
    
  end

  def find
    query = params[:query]

    tracks = ActiveRecord::Base.connection.execute("
      SELECT * 
      FROM `tracks` 
      WHERE tname LIKE '#{query}%'").to_a

    tracks.each do |track|
      track.push(track_path(track[0]))
    end

    games = ActiveRecord::Base.connection.execute("
      SELECT * 
      FROM `games`
      WHERE gname LIKE '#{query}%'").to_a

    games.each do |game|
      game.push(game_path(game[0]))
    end

    consoles = ActiveRecord::Base.connection.execute("
      SELECT * 
      FROM `consoles`
      WHERE gcname LIKE '#{query}%'").to_a

    consoles.each do |console|
      console.push(console_path(console[0]))
    end

    items = ActiveRecord::Base.connection.execute("
      SELECT * 
      FROM `items`
      WHERE iname LIKE '#{query}%'").to_a

    items.each do |item|
      item.push(item_path(item[0]))
    end

    characters = ActiveRecord::Base.connection.execute("
      SELECT * 
      FROM `characters`
      WHERE cname LIKE '#{query}%'").to_a

    characters.each do |character|
      character.push(character_path(character[0]))
    end

    results = tracks + games + consoles + items + characters

    respond_to do |format|
      format.json {render json: results}
    end
  end
end