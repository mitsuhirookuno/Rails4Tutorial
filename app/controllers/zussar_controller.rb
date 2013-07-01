# -*- encoding: utf-8 -*-

class ZussarController < ApplicationController
  
  def index
    connection = Faraday::Connection.new( :url => "http://www.zusaar.com" ) do |builder|
      builder.use Faraday::Request::UrlEncoded  # リクエストパラメータを URL エンコードする
      # builder.use Faraday::Response::Logger     # リクエストを標準出力に出力する
      builder.use Faraday::Adapter::NetHttp     # Net/HTTP をアダプターに使う
    end
    
    response = connection.get '/api/event/?event_id=864003'
    @zusaar_event_list = ActiveSupport::JSON.decode( response.body )
  end
  
end
