# -*- encoding: utf-8 -*-

class QiitaController < ApplicationController
  
  def index
    @qiita_timelines = Qiita.user_items
  end

  def tags
    @qiita_timelines =Qiita.tag_items params[:tag]
  end

  def users
    @qiita_timelines =Qiita.user_items params[:user]
  end
  
  private if Rails.env != "development"
  
  def get_qiita_connection
    get_connection( "https://qiita.com/" )
  end
  
end
