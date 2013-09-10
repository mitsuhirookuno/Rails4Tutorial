# -*- encoding: utf-8 -*-

#
# ZussarAPIを利用する：コントローラー
#
# @see http://www.zusaar.com/doc/api.html ZussarAPI
# @see http://rubygems.org/gems/zusaar ZussarAPIのGem
#
class Zussar::EventsController < ApplicationController

  skip_before_filter :authenticate

  #
  # 一覧表示
  #   イベントの一覧を表示します
  #
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
    search_results_events = Zusaar.search_events(@parameters)
    @events = search_results_events.events
  end

  #
  # イベント表示
  #   イベントの詳細を表示します
  #
  def show
    search_results_events = Zusaar.search_events( event_id: params[:id] )
    search_results_users  = Zusaar.search_users( event_id: params[:id] )

    @event = search_results_events.events.first
    @limit = search_results_users.events.first.limit
    @users = search_results_users.events.first.users
  end

end
