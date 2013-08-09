class AtndController < ApplicationController

  skip_before_filter :authenticate

  def index
    @page_size = 10
    @offset = 1
    if params.key?(:page) == false
      @page = 1
    else
      @page = Integer(params.fetch(:page))
    end
    @offset += ((@page - 1 ) * @page_size )
    @parameters = { count: @page_size, start: @offset }
    @events = Atndr::Event.new.get_event(@parameters)
  end

  def events
    search_result = Atndr::Event.new.get_event(params)
    @event = search_result.first
  end

  def users
    search_result = Atndr::User.new.get_user(params)
    @events = search_result
  end

end
