require_relative './lib/bookmark'
require_relative './lib/database_connection_setup'
require 'sinatra'
require 'sinatra/flash'
require 'uri'


class BookmarkManager < Sinatra::Base

  enable :sessions
  register Sinatra::Flash

  get '/' do
    erb :index
  end

  get '/bookmarks' do
    @all_bookmarks = Bookmark.all
    erb :bookmarks
  end

  post '/bookmark_added' do
    if Bookmark.add_bookmark(params[:new_bookmark], params[:new_bookmark_title])
      redirect('/bookmarks')
    else
      flash[:notice] = "You must submit a valid URL"
      redirect('/')
    end
  end

  post '/bookmark_deleted' do
    Bookmark.delete(params["delete"])
    redirect('/bookmarks')
  end

  post '/bookmark_update' do
    Bookmark.update(params.key('update'), params["update_title"])
    redirect('/bookmarks')
  end

  get '/bookmarks/:id/comments/new' do
    @bookmark_id = params[:id]
    erb :'comments/new'
  end

  post '/bookmarks/:id/comments' do
    Comment.create(text: params[:comment], bookmark_id: params[:id])
    redirect('/bookmarks')
  end

  run! if app_file == $0
end
