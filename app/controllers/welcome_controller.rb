# -*- encoding: utf-8 -*-

class WelcomeController < ApplicationController
  
  def index
    
    connection = Faraday::Connection.new( :url => "https://qiita.com/" ) do |builder|
      builder.use Faraday::Request::UrlEncoded  # リクエストパラメータを URL エンコードする
      # builder.use Faraday::Response::Logger     # リクエストを標準出力に出力する
      builder.use Faraday::Adapter::NetHttp     # Net/HTTP をアダプターに使う
    end
    
    response = connection.get '/api/v1/items'
    @qiita_timelines = ActiveSupport::JSON.decode( response.body )
    
  end
  
  def reference
  end
  
end
