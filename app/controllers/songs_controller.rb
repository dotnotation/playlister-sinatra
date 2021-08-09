require 'rack-flash'

class SongsController < ApplicationController
    use Rack::Flash

    get '/songs' do
        @songs = Song.all
        erb :'/songs/index'
    end

    get '/songs/new' do
        erb :'/songs/new'
    end
    
    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        erb :'/songs/show'
    end

    post '/songs' do
        @song = Song.create(params[:song])
        @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
        @song.genre_ids = params[:genres]
        
        if @song.save
            flash[:message] = "Successfully created song."
            redirect to "/songs/#{@song.slug}"
        else
            flash[:message] = "There was a problem. Please try again."
            redirect to "/songs/new"
        end
    end

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        erb :'/songs/edit'
    end

    patch '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        @song.update(params[:song])
        @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
        @song.genre_ids = params[:genres]
        
        if @song.save
            flash[:message] = "Successfully updated song."
            redirect to "/songs/#{@song.slug}"
        else
            flash[:message] = "Unable to update song. Please try again."
            redirect to "/songs/#{@song.slug}/edit"
        end
    end

end