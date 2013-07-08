# -*- encoding: utf-8 -*-

class ZussarController < ApplicationController
  
  def index
    response = get_zusaar_connection.get "/api/event/?event_id=#{params[:event_id]}"
    @zusaar_event_list = ActiveSupport::JSON.decode( response.body )
    
    response = get_zusaar_connection.get "/api/event/user/?event_id=#{params[:event_id]}"
    @zusaar_user_list = ActiveSupport::JSON.decode( response.body )
  end
  
  def users
    response = get_zusaar_connection.get "/api/event/user/?user_id=#{params[:user_id]}"
    @zusaar_user_list = ActiveSupport::JSON.decode( response.body )
    @zusaar_user = @zusaar_user_list['event'][0]['users'].find{|user| user['user_id'] == params['user_id'] }
    
    response = get_zusaar_connection.get "/api/event/?owner_id=#{params[:user_id]}"
    @zusaar_owner_event_list = ActiveSupport::JSON.decode( response.body )
    
    response = get_zusaar_connection.get "/api/event/?user_id=#{params[:user_id]}"
    @zusaar_user_event_list = ActiveSupport::JSON.decode( response.body )
  end
  
  private if Rails.env != "development"
  
  def get_zusaar_connection
    get_connection( "http://www.zusaar.com" )
  end
  
end
