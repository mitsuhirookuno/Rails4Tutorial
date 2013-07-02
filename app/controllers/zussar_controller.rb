# -*- encoding: utf-8 -*-

class ZussarController < ApplicationController
  
  def index
    connection = Faraday::Connection.new( :url => "http://www.zusaar.com" ) do |builder|
      builder.use Faraday::Request::UrlEncoded  # リクエストパラメータを URL エンコードする
      # builder.use Faraday::Response::Logger     # リクエストを標準出力に出力する
      builder.use Faraday::Adapter::NetHttp     # Net/HTTP をアダプターに使う
    end
    
    response = connection.get "/api/event/?event_id=#{params[:event_id]}"
    @zusaar_event_list = ActiveSupport::JSON.decode( response.body )
    
    response = connection.get "/api/event/user/?event_id=#{params[:event_id]}"
    @zusaar_user_list = ActiveSupport::JSON.decode( response.body )
  end
  
  def users
    connection = Faraday::Connection.new( :url => "http://www.zusaar.com" ) do |builder|
      builder.use Faraday::Request::UrlEncoded  # リクエストパラメータを URL エンコードする
      # builder.use Faraday::Response::Logger     # リクエストを標準出力に出力する
      builder.use Faraday::Adapter::NetHttp     # Net/HTTP をアダプターに使う
    end
    
    response = connection.get "/api/event/user/?user_id=#{params[:user_id]}"
    @zusaar_user_list = ActiveSupport::JSON.decode( response.body )
    @zusaar_user = @zusaar_user_list['event'][0]['users'].find{|user| user['user_id'] == params['user_id'] }
    
    response = connection.get "/api/event/?owner_id=#{params[:user_id]}"
    @zusaar_owner_event_list = ActiveSupport::JSON.decode( response.body )
    
    response = connection.get "/api/event/?user_id=#{params[:user_id]}"
    @zusaar_user_event_list = ActiveSupport::JSON.decode( response.body )
  end
  
end
