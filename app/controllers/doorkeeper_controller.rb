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
  end

  def users
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
