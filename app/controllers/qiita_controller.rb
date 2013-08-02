# -*- encoding: utf-8 -*-

#
# QiitaAPIを利用する：コントローラー
#
# @see https://qiita.com/docs ConnpassAPIのリファレンス
# @see https://rubygems.org/gems/qiita ConnpassAPIのGem
#
class QiitaController < ApplicationController

  #
  # 一覧表示
  #   記事の一覧を表示します
  #
  def index
    # ToDo : memcachedで負荷を軽減したい
    @qiita_timelines = Qiita.user_items
  end

  #
  # タグ表示
  #   タグで一覧を表示します
  #
  def tags
    @qiita_timelines = Qiita.tag_items params[:tag]
  end

  #
  # ユーザー表示
  #   ユーザーで一覧を表示します
  #
  def users
    @qiita_timelines = Qiita.user_items params[:user]
  end
  
  private if Rails.env != "development"

  #
  # HttpClient生成
  #   ユーザーで一覧を表示します
  # @return [Faraday::Connection] コネクション
  def get_qiita_connection
    # FIXME : リトライ処理の実装
    get_connection( "https://qiita.com/" )
  end
  
end
