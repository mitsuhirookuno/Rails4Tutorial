# -*- encoding: utf-8 -*-

#
# AtndAPIを利用する：コントローラー
#
# @see http://api.atnd.org/ AtndAPI
# @see http://rubygems.org/gems/atndr AtndAPIのGem
#

class Atnd::EventsController < ApplicationController

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

  def show
    search_result = Atndr::Event.new.get_event( event_id: params[:id] )
    @event = search_result.first
  end

end
