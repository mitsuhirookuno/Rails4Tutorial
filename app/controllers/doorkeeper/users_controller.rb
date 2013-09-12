# -*- encoding: utf-8 -*-

#
# DoorKeeperAPIを利用する：コントローラー
#
# @see http://www.doorkeeperhq.com/developer/api DoorKeeperAPI
#

class Doorkeeper::UsersController < ApplicationController

  skip_before_filter :authenticate

  def show
    @events = ActiveSupport::JSON.decode(get_doorkeeper_connection.get("/groups/#{params[:id]}/events").body)
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
