require_relative './lib/bookmark'
require 'sinatra/base'

class BookmarkManager < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/bookmarks' do
    @all_bookmarks = Bookmark.all
    erb :bookmarks
  end
  run! if app_file == $0
end
