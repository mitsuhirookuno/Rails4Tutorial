# -*- encoding: utf-8 -*-

#
# QiitaAPIを利用する：コントローラー
#
# @see https://qiita.com/docs ConnpassAPIのリファレンス
# @see https://rubygems.org/gems/qiita ConnpassAPIのGem
#
class QiitaController < ApplicationController

  skip_before_filter :authenticate

  #
  # 一覧表示
  #   記事の一覧を表示します
  #
  def index
    @page_size = 20
    @offset = 1
    if params.key?(:page) == false
      @page = 1
    else
      @page = Integer(params.fetch(:page))
    end
    @offset += ((@page - 1 ) * @page_size )
    @parameters = { per_page: @page_size, page: @page }
    @qiita_timelines = Qiita.user_items( nil, @parameters )
  end

  #
  # タグ表示
  #   タグで一覧を表示します
  #
  def tags
    @page_size = 20
    @offset = 1
    if params.key?(:page) == false
      @page = 1
    else
      @page = Integer(params.fetch(:page))
    end
    @offset += ((@page - 1 ) * @page_size )
    @parameters = { per_page: @page_size, page: @page }
    @qiita_timelines = Qiita.tag_items( params[:tag], @parameters )
  end

  #
  # ユーザー表示
  #   ユーザーで一覧を表示します
  #
  def users
    @page_size = 20
    @offset = 1
    if params.key?(:page) == false
      @page = 1
    else
      @page = Integer(params.fetch(:page))
    end
    @offset += ((@page - 1 ) * @page_size )
    @parameters = { per_page: @page_size, page: @page }
    @qiita_timelines = Qiita.user_items( params[:user], @parameters )
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

  private if Rails.env != "development"

  def breadcrumb
    module_name = 'qiita'
    template = <<-"EOS"
          <ul class="breadcrumb">
            <li><a href="/">Home</a> <span class="divider">/</span></li>
            <li>#{module_name.camelize} <span class="divider">/</span></li>
            <li class="active">#{action_name.camelize}</li>
          </ul>
    EOS
  end

end
