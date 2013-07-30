# -*- encoding: utf-8 -*-

#
# ConnpassAPIを利用する：コントローラー
#
# @see http://connpass.com/about/api/ ConnpassAPIのリファレンス
#
class ConnpassController < ApplicationController

#
# 一覧表示
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
    search_results_events = Connpass.event_search(@parameters)
    @events = search_results_events['events']
  end

  #
  # イベント表示
  #
  def events
    search_result = Connpass.event_search(params)
    @event = search_result['events'].first
  end

  #
  # ユーザー表示
  #
  def users
    search_result = Connpass.event_search(params)
    @events = search_result['events']
  end
  
end
