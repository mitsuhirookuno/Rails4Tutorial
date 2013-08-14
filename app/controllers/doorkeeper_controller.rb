# -*- encoding: utf-8 -*-

#
# DoorKeeperAPIを利用する：コントローラー
#
# @see http://www.doorkeeperhq.com/developer/api DoorKeeperAPI
#

class DoorkeeperController < ApplicationController

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

  def events
    # aa = ActiveSupport::JSON.decode(get_doorkeeper_connection.get("/events?since=2013-09-03T10:20:00Z&until=2013-09-03T10:20:00Z").body)
    # イベントを直接IDで指定することはできない
    @events = ActiveSupport::JSON.decode(get_doorkeeper_connection.get("/events?id=#{params['event_id']}").body)
  end

  def users
    @events = ActiveSupport::JSON.decode(get_doorkeeper_connection.get("/groups/#{params['group_id']}/events").body)
  end

  private if Rails.env != "development"

  #
  # HttpClient生成
  #   ユーザーで一覧を表示します
  # @return [Faraday::Connection] コネクション
  def get_doorkeeper_connection
    # FIXME : リトライ処理の実装
    get_connection( "http://api.doorkeeper.jp/" )
  end

end
