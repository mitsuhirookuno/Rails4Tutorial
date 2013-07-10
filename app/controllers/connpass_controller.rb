class ConnpassController < ApplicationController

  def index
    search_result = Connpass.event_search(params)
    @event = search_result['events'].first
  end

  def users
    search_result = Connpass.event_search(params)
    @events = search_result['events']
  end
  
end
