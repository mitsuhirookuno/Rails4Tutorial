# -*- encoding: utf-8 -*-

class QiitaController < ApplicationController
  
  def index
    connection = get_qiita_connection
    response = connection.get '/api/v1/items'
    @qiita_timelines = ActiveSupport::JSON.decode( response.body )
  end

  def tags
    connection = get_qiita_connection
    response = connection.get "/api/v1/tags/#{params[:tag]}/items"
    @qiita_timelines = ActiveSupport::JSON.decode( response.body )
  end

  def users
    connection = get_qiita_connection
    response = connection.get "/api/v1/users/#{params[:user]}/items"
    @qiita_timelines = ActiveSupport::JSON.decode( response.body )
  end
  
  private if Rails.env != "development"
  
  def get_qiita_connection
    get_connection( "https://qiita.com/" )
  end
  
end
