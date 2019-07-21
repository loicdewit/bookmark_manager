
require 'bookmark'

describe Bookmark do

  subject(:bookmark) { described_class.new }

  describe '#.all' do
    it 'returns all saved bookmarks' do
      connection = PG.connect(dbname: "bookmark_manager_test")
      connection.exec("INSERT INTO bookmarks(url, title) VALUES('https://www.google.com', 'GOOGLE');")
      bookmarks = Bookmark.all
      expect(bookmarks.first.title).to eq("GOOGLE")
    end
  end
  describe '#.add_bookmark' do
    it 'adds a bookmark to the database' do
      connection = PG.connect(dbname: "bookmark_manager_test")
      Bookmark.add_bookmark('https://www.youtube.com', 'YOUTUBE')
      result = connection.exec("SELECT * FROM bookmarks;")
      expect(result[0]['title']).to eq 'YOUTUBE'
      expect(result[0]['url']).to eq 'https://www.youtube.com'
    end
  end
  describe '#.delete' do
    it 'deletes a bookmark from the database' do
      connection = PG.connect(dbname: "bookmark_manager_test")
      Bookmark.add_bookmark('https://www.youtube.com', 'YOUTUBE')
      result = connection.exec("SELECT * FROM bookmarks;")
      Bookmark.delete(result[0]['id'])
      supposedly_empty = connection.exec("SELECT * FROM bookmarks;")
      expect(supposedly_empty.ntuples).to eq 0
    end
  end
  describe '#.update' do
    it "updates the bookmark's title in the database" do
      connection = PG.connect(dbname: "bookmark_manager_test")
      Bookmark.add_bookmark('https://www.youtube.com', 'YOUTUBE')
      result = connection.exec("SELECT * FROM bookmarks;")
      Bookmark.update(result[0]['id'], 'Best VideoWebsite')
      result = connection.exec("SELECT * FROM bookmarks;")
      result[0]['title'] = 'Best VideoWebsite'
    end
  end

  describe '#.comments' do
    it "returns a list of comments on the bookmark" do
      bookmark = Bookmark.add_bookmark('http://www.makersacademy.com', 'Makers Academy')
      DatabaseConnection.query("INSERT INTO comments (id, text, bookmark_id) VALUES(1, 'Test comment', #{bookmark.id});")
      comment = bookmark.comments.first
      expect(comment['text']).to eq 'Test comment'
    end
  end
end
