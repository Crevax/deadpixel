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
        :part => "snippet",
        :channelId => ENV["CHANNEL_ID"],
        :maxResults => 10
      }
    )
    ##
    #@video = client.execute!(
    #  :api_method => youtube.videos.list,
    #  :parameters => {
    #    :part => "snippet",
    #    :id => "8L5pg8H_m-I"
    #  }
    #) 
  end
end
