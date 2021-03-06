class MessagesController < ApplicationController
  def index
  end

  def get
    results = []

    messages = ActiveRecord::Base.connection.execute("
      SELECT um.`username`, m.`text`, m.`mid` 
      FROM messages m
      JOIN user_messages um
      ON m.mid = um.mid
      JOIN users u
      ON u.username = um.username
      ORDER BY m.`mid` DESC
      LIMIT 20").to_a.reverse

    messages.each do |message|
      results.push(message)
    end

    respond_to do |format|
      format.json {render json: results}
    end
  end

  def add
    text = params[:message][:text].gsub("'", %q(\\\'))

    id = Message.last ? Message.last.id + 1 : 1

    ActiveRecord::Base.connection.execute("
      INSERT INTO messages(`mid`, `text`) 
      VALUES (#{null_or_not(id)},
        '#{null_or_not(text)}')")

    username = current_user.username

    ActiveRecord::Base.connection.execute("
      INSERT INTO user_messages (`username`, `mid`) 
      VALUES ('#{null_or_not(username)}',
        '#{null_or_not(id)}')")

    render :nothing => true
  end

  def delete
    mid = params[:id]

    if current_user.admin == true
      ActiveRecord::Base.connection.execute("
        DELETE FROM messages 
        WHERE `mid` = #{null_or_not(mid)}
        LIMIT 1")

      ActiveRecord::Base.connection.execute("
        DELETE FROM user_messages 
        WHERE `mid` = #{null_or_not(mid)}
        LIMIT 1")
    end

    render :nothing => true
  end
end
