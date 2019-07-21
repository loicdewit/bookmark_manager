require_relative './database_connection_setup'
require 'pg'
require 'uri'

class Comment

  attr_reader :id, :text, :bookmark_id

  def initialize(id:, text:, bookmark_id:)
    @id = id
    @text = text
    @bookmark_id = bookmark_id
  end

  def self.create(text:, bookmark_id:)
    result = DatabaseConnection.query(
      "INSERT INTO comments (bookmark_id, text) VALUES ('#{bookmark_id}', '#{text}')
      RETURNING id, text, bookmark_id;")
    Comment.new(
      id: result[0]['id'],
      text: result[0]['text'],
      bookmark_id: result[0]['bookmark_id']
    )
  end
end

class Bookmark

  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM bookmarks;")
    result.map do |bookmark|
      Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
    end
  end

  def self.add_bookmark(url, title)
    return false unless is_url?(url)
    result = DatabaseConnection.query("INSERT INTO bookmarks
       (url, title) VALUES('#{url}', '#{title}')
       RETURNING id, title, url;")
    bookmark = Bookmark.new(id: result[0]['id'],
       title: result[0]['title'],
       url: result[0]['url'])
  end

  def self.delete(id)
    result = DatabaseConnection.query("DELETE FROM bookmarks WHERE id = #{id};")
  end

  def self.update(id, title)
    DatabaseConnection.query("UPDATE bookmarks SET title = '#{title}' WHERE id = '#{id}';")
  end

  def self.is_url?(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end

  def comments
    DatabaseConnection.query("SELECT * FROM comments WHERE bookmark_id = #{@id};")
  end

end
