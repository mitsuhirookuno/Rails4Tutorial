# -*- encoding: utf-8 -*-

#
# ZussarAPIを利用する：コントローラー
#
# @see http://www.zusaar.com/doc/api.html ZussarAPI
# @see http://rubygems.org/gems/zusaar ZussarAPIのGem
#
class Zussar::UsersController < ApplicationController

  skip_before_filter :authenticate

  #
  # ユーザー表示
  #   ユーザーの詳細を表示します
  #
  def show
    search_results_users = Zusaar.search_users( user_id: params[:id] )
    @user = search_results_users.events.first.users.find{|user| user.user_id == params['id'] }

    search_results_events = Zusaar.search_events( owner_id: params[:id] )
    @owner_events = search_results_events.events

    search_results_events = Zusaar.search_events( user_id: params[:id] )
    @user_events = search_results_events.events
  end

end
