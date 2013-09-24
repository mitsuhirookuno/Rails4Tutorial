# -*- encoding: utf-8 -*-

#
# ConnpassAPIを利用する：コントローラー
#
# @see http://connpass.com/about/api/ ConnpassAPIのリファレンス
# @see http://rubygems.org/gems/connpass ConnpassAPIのGem
#

class Connpass::EventsController < ApplicationController

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
    search_results_events = Connpass.event_search(@parameters)
    @events = search_results_events['events']
  end

  #
  # イベント表示
  #   イベントの詳細を表示します
  #
  def show
    search_result = Connpass.event_search(event_id: params[:id])
    @event = search_result['events'].first
  end

  private if Rails.env != "development"

  def breadcrumb
    breadcrumb_base('connpass')
  end

end
