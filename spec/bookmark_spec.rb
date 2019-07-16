
require 'bookmark'

describe Bookmark do

  subject(:bookmark) { described_class.new }

  describe '#.all' do
    it 'returns all saved bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')
      connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.google.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.facebook.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.twitter.com');")
      bookmarks = Bookmark.all
      expect(bookmarks).to include("http://www.google.com")
      expect(bookmarks).to include("http://www.facebook.com")
      expect(bookmarks).to include("http://www.twitter.com")
    end
  end
end
