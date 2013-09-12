# -*- encoding: utf-8 -*-

#
# DoorKeeperAPIを利用する：コントローラー
#
# @see http://www.doorkeeperhq.com/developer/api DoorKeeperAPI
#

class Doorkeeper::EventsController < ApplicationController

  skip_before_filter :authenticate

  def index
    @page_size = 25
    if params.key?(:page) == false
      @page = 1
    else
      @page = Integer(params.fetch(:page))
    end

    @events = ActiveSupport::JSON.decode(get_doorkeeper_connection.get("/events?page=#{@page}").body)
    @event = @events.first
  end

  def show
    # aa = ActiveSupport::JSON.decode(get_doorkeeper_connection.get("/events?since=2013-09-03T10:20:00Z&until=2013-09-03T10:20:00Z").body)
    # イベントを直接IDで指定することはできない
    starts_at = params[:starts_at]
    ends_at = params[:ends_at]

    @events = ActiveSupport::JSON.decode(get_doorkeeper_connection.get("/events?since=#{starts_at}&until=#{ends_at}}").body)
    @event = @events.find{|e| e["event"]["id"] == params[:id].to_i }['event']
  end

  #
  # HttpClient生成
  #   ユーザーで一覧を表示します
  # @return [Faraday::Connection] コネクション
  def get_doorkeeper_connection
    # FIXME : リトライ処理の実装
    get_connection( "http://api.doorkeeper.jp/" )
  end

end
