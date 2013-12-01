class WelcomeController < ApplicationController
  def index
    @games = ActiveRecord::Base.connection.execute("SELECT * FROM games")
  end
end
