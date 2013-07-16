# -*- encoding: utf-8 -*-

class ZussarController < ApplicationController
  
  def index
    @page_size = 10
    if params.key?(:page) == false
      @offset = 1
    else
      @offset = Integer(params.fetch(:page))
    end
    
    @parameters = { count: @page_size, start: (@offset * @page_size) }
    search_results_events = Zusaar.search_events(@parameters)
    @events = search_results_events.events
  end
  
  def events
    search_results_events = Zusaar.search_events( params )
    search_results_users  = Zusaar.search_users( params )
    
    @event = search_results_events.events.first
    @limit = search_results_users.events.first.limit
    @users = search_results_users.events.first.users
  end
  
  def users
    search_results_users = Zusaar.search_users( params )
    @user = search_results_users.events.first.users.find{|user| user.user_id == params['user_id'] }
    
    search_results_events = Zusaar.search_events( owner_id: params[:user_id] )
    @owner_events = search_results_events.events
    
    search_results_events = Zusaar.search_events( user_id: params[:user_id] )
    @user_events = search_results_events.events
  end
  
  private if Rails.env != "development"
  
  def get_zusaar_connection
    get_connection( "http://www.zusaar.com" )
  end
  
end
