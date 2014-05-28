class StaticPagesController < ApplicationController

  def home
    $client = YouTubeIt::Client.new(:dev_key=> "")
    @videos = $client.videos_by(:user => "DeadPixelShow", :max_results => 6)
  end
end
