# -*- encoding: utf-8 -*-

class WelcomeController < ApplicationController

  skip_before_filter :authenticate

  def index
  end

  def reference
  end

  def search

    @list = Array.new
    thread_list = Array.new

    if params[:zussar].presence
      thread_list.push(
        Thread.new {
          @zussar_events = Zusaar.search_events( keyword: params[:keyword], count: 100 )
          @zussar_events.events.each{|event| @list.push(Zussar::TimeLine.new(event)) }
        }
      )
    end

    if params[:connpass].presence
      thread_list.push(
        Thread.new {
          @connpass_events = Connpass.event_search( keyword: params[:keyword], count: 100 )
          @connpass_events['events'].each{|event| @list.push(Connpass::TimeLine.new(event)) }
        }
      )
    end

    if params[:atnd].presence
      thread_list.push(
        Thread.new {
          @atnd_events = ActiveSupport::JSON.decode( get_atnd_connection.get( "/eventatnd/event/?format=json&count=100&keyword=#{URI.encode(params[:keyword])}").body )
          if @atnd_events["results_available"] > 0
            @atnd_events["events"].first['event'].each{|event| @list.push(Atnd::TimeLine.new(event)) }
          end
        }
      )
    end

    if params[:doorkeeper].presence
      thread_list.push(
        Thread.new {
          @doorkeeper_events = ActiveSupport::JSON.decode( get_doorkeeper_connection.get( "/events?q=#{params[:keyword]}").body )
          @doorkeeper_events.each{|event| @list.push(Doorkeeper::TimeLine.new(event)) }
        }
      )
    end

    if params[:qiita].presence
      thread_list.push(
        Thread.new {
          per_page_max = 100
          page_first = 1
          @parameters = { per_page: per_page_max, page: page_first }
          @qiita_timelines = Qiita.search_items( params[:keyword], @parameters )
          @qiita_timelines.each{|timeline| @list.push(Qiita::TimeLine.new(timeline)) }
        }
      )
    end

    # binding.pry
    thread_list.each {|t| t.join }
    @list.sort_by!{|r| r.started_at }
  end

  def get_doorkeeper_connection
    # FIXME : リトライ処理の実装
    get_connection( "http://api.doorkeeper.jp/" )
  end

  def get_atnd_connection
    get_connection( "http://api.atnd.org/" )
  end

end
