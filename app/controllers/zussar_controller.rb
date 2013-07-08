# -*- encoding: utf-8 -*-

class ZussarController < ApplicationController
  
  def index
    search_results_events = Zusaar.search_events( params )
    search_results_users = Zusaar.search_users( params )
    
    @event = search_results_events.events.first
    @limit = search_results_users.events.first.limit
    @users = search_results_users.events.first.users
  end
  
  def users
    search_results_users = Zusaar.search_users( params )
    @user = search_results_users.events.first.users.find{|user| user.user_id == params['user_id'] }
#    response = get_zusaar_connection.get "/api/event/user/?user_id=#{params[:user_id]}"
#    @zusaar_user_list = ActiveSupport::JSON.decode( response.body )
#    @zusaar_user = @zusaar_user_list['event'][0]['users'].find{|user| user['user_id'] == params['user_id'] }
    
#    response = get_zusaar_connection.get "/api/event/?owner_id=#{params[:user_id]}"
#    @zusaar_owner_event_list = ActiveSupport::JSON.decode( response.body )
    search_results_events = Zusaar.search_events( owner_id: params[:user_id] )
    @owner_events = search_results_events.events
    
#    response = get_zusaar_connection.get "/api/event/?user_id=#{params[:user_id]}"
#    @zusaar_user_event_list = ActiveSupport::JSON.decode( response.body )
    search_results_events = Zusaar.search_events( user_id: params[:user_id] )
    @user_events = search_results_events.events
  end
  
  private if Rails.env != "development"
  
  def get_zusaar_connection
    get_connection( "http://www.zusaar.com" )
  end
  
end
