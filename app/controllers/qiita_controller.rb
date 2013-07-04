# -*- encoding: utf-8 -*-

class QiitaController < ApplicationController
  
  def index
    connection = get_connection
    response = connection.get '/api/v1/items'
    @qiita_timelines = ActiveSupport::JSON.decode( response.body )
  end

  def tags
    connection = get_connection
    response = connection.get "/api/v1/tags/#{params[:tag]}/items"
    @qiita_timelines = ActiveSupport::JSON.decode( response.body )
  end

  def users
    connection = get_connection
    response = connection.get "/api/v1/users/#{params[:user]}/items"
    @qiita_timelines = ActiveSupport::JSON.decode( response.body )
  end
  
  private if Rails.env != "development"
  
  def get_connection
    connection = Faraday::Connection.new( :url => "https://qiita.com/" ) do |builder|
      builder.use Faraday::Request::UrlEncoded  # リクエストパラメータを URL エンコードする
      # builder.use Faraday::Response::Logger     # リクエストを標準出力に出力する
      builder.use Faraday::Adapter::NetHttp     # Net/HTTP をアダプターに使う
    end
    connection
  end
  
end
