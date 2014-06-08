class StaticPagesController < ApplicationController

  YOUTUBE_READONLY_SCOPE = 'https://www.googleapis.com/auth/youtube.readonly'
  YOUTUBE_API_SERVICE_NAME = 'youtube'
  YOUTUBE_API_VERSION = 'v3'

  def home
    client = Google::APIClient.new(
      :application_name => "DeadPixel",
      :application_version => "1.0",
      :key => ENV["GOOGLE_API_KEY"],
      :authorization => nil
    )
    youtube = client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)

    @playlists = client.execute!(
      :api_method => youtube.playlists.list,
      :parameters => {
        :part => "snippet, contentDetails",
        :channelId => ENV["CHANNEL_ID"],
        :maxResults => 10
      }
    )
  end

  def playlist
    client = Google::APIClient.new(
      :application_name => "DeadPixel",
      :application_version => "1.0",
      :key => ENV["GOOGLE_API_KEY"],
      :authorization => nil
    )
    youtube = client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)

    @playlist = client.execute!(
      :api_method => youtube.playlists.list,
      :parameters => {
        :part => "snippet",
        :id => params[:id],
        :maxResults => 1
      }
    )

    if @playlist.data.items.first.snippet.channelId != ENV["CHANNEL_ID"]
      render(:file => File.join(Rails.root, 'public/406.html'), :status => 406, :layout => false)
    end

    @videos = client.execute!(
      :api_method => youtube.playlist_items.list,
      :parameters => {
        :part => "snippet",
        :playlistId => params[:id],
        :maxResults => 6,
        :pageToken => params[:page_token]
      }
    )
  end

  def watch
    client = Google::APIClient.new(
      :application_name => "DeadPixel",
      :application_version => "1.0",
      :key => ENV["GOOGLE_API_KEY"],
      :authorization => nil
    )
    youtube = client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)

    @video = client.execute!(
      :api_method => youtube.videos.list,
      :parameters => {
        :part => "snippet",
        :id => params[:id]
      }
    )

    if @video.data.items.first.snippet.channelId != ENV["CHANNEL_ID"]
      render(:file => File.join(Rails.root, 'public/406.html'), :status => 406, :layout => false)
    end
  end
end
