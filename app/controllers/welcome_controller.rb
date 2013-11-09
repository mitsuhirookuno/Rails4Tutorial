# -*- encoding: utf-8 -*-

class WelcomeController < ApplicationController

  skip_before_filter :authenticate

  def index
  end

  def reference
  end

  def search

    @list = Array.new

    @zussar_events = Zusaar.search_events( keyword: params[:keyword] )
    logger.info @zussar_events.inspect
    @zussar_events.events.each{|event| @list.push(Zussar::TimeLine.new(event)) }

    @connpass_events = Connpass.event_search( keyword: params[:keyword] )
    @connpass_events['events'].each{|event| @list.push(Connpass::TimeLine.new(event)) }
    logger.info @connpass_events.inspect

    @atnd_events = Atndr::Event.new.get_event( keyword: params[:keyword] )
    @atnd_events.each{|event| @list.push(Atnd::TimeLine.new(event)) }

    @doorkeeper_events = ActiveSupport::JSON.decode( get_doorkeeper_connection.get("/events?q=#{params[:keyword]}").body )
    @doorkeeper_events.each{|event| @list.push(Doorkeeper::TimeLine.new(event)) }

    @parameters = { per_page: @page_size, page: @page }
    @qiita_timelines = Qiita.user_items( nil, @parameters )
    @qiita_timelines.each{|timeline| @list.push(Qiita::TimeLine.new(timeline)) }

    @list.sort_by!{|r| r.started_at }
  end

  def get_doorkeeper_connection
    # FIXME : リトライ処理の実装
    get_connection( "http://api.doorkeeper.jp/" )
  end

end
