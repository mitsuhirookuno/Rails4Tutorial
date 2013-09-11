# -*- encoding: utf-8 -*-

#
# ConnpassAPIを利用する：コントローラー
#
# @see http://connpass.com/about/api/ ConnpassAPIのリファレンス
# @see http://rubygems.org/gems/connpass ConnpassAPIのGem
#

class Connpass::UsersController < ApplicationController

  skip_before_filter :authenticate

  #
  # ユーザー表示
  #   ユーザーの詳細を表示します
  #
  def show
    search_result = Connpass.event_search( owner_nickname: params[:id] )
    @events = search_result['events']
  end

end
