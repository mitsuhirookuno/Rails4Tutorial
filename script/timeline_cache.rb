def get_connection( domain )
  connection = Faraday::Connection.new( :url => domain ) do |builder|
    builder.use Faraday::Request::UrlEncoded
    builder.use Faraday::Adapter::NetHttp
  end
  connection
end

def get_doorkeeper_connection
  get_connection( "http://api.doorkeeper.jp/" )
end

def get_atnd_connection
  get_connection( "http://api.atnd.org/" )
end

def main
  start_time = Time.now

  search_words = SearchWord.all.to_a
  search_word = search_words.find{|search_word| search_word.timelines.size == 0 }
  if search_word.blank?
    search_word = search_words.min_by{|search_word| search_word.timelines.first.updated_at }
    puts "search reload #{search_word.name}"
  else
    puts "search first load #{search_word.name}"
  end

  # Zusaar：クラス
  zusaar = Zusaar.search_events( keyword: search_word.name, count: 100 )
  zussar_compress_json_list = Array.new
  zusaar.events.each{ |event|
    json = event.attr.to_json
    compress_json = Zlib::Deflate.deflate(json)
    zussar_compress_json_list.push(compress_json)

    event = Zusaar::Event.new( ActiveSupport::JSON.decode(Zlib::Inflate.inflate(compress_json)) )
    timeline = Zussar::TimeLine.new(event)
    print "Zussar : %s \n" % timeline.title
  }

  # Connpass：マップ
  connpass = Connpass.event_search( keyword: search_word.name, count: 100 )
  connpass_compress_json_list = Array.new
  # json = connpass['events'].first.to_json
  connpass['events'].each{|event|
    compress_json = Zlib::Deflate.deflate(event.to_json)
    connpass_compress_json_list.push(compress_json)

    event = Hashie::Mash.new(ActiveSupport::JSON.decode(Zlib::Inflate.inflate(compress_json)))
    timeline = Connpass::TimeLine.new(event)
    print "Connpass : %s \n" % timeline.title
  }

  # Qiita：マップ
  qiita = Qiita.search_items( search_word.name, { per_page: 100, page: 1 } )
  qiita_compress_json_list = Array.new
  qiita.each{ |event|
    json = event.to_json
    compress_json = Zlib::Deflate.deflate(json)
    qiita_compress_json_list.push(compress_json)

    event = Hashie::Mash.new(ActiveSupport::JSON.decode(Zlib::Inflate.inflate(compress_json)))
    timeline = Qiita::TimeLine.new(event)
    print "Qiita : %s \n" % timeline.title
  }

  #  @qiita_timelines.each{|timeline| @list.push(Qiita::TimeLine.new(timeline)) }

  # Atnd
  json = get_atnd_connection.get( "/eventatnd/event/?format=json&count=1&keyword=#{URI.encode(search_word.name)}").body
  atnd_compress_json = Zlib::Deflate.deflate(json)

  events = ActiveSupport::JSON.decode( Zlib::Inflate.inflate(atnd_compress_json) )
  if events["results_available"] > 0
    event = events["events"].first['event'].first
    timeline = Atnd::TimeLine.new(event)
    print "Atnd : %s \n" % timeline.title
  end

  # Doorkeeper
  json = get_doorkeeper_connection.get( "/events?q=#{search_word.name}" ).body
  doorkeeper_compress_json = Zlib::Deflate.deflate(json)

  events = ActiveSupport::JSON.decode( Zlib::Inflate.inflate(doorkeeper_compress_json) )
  events.each{|event|
    timeline = Doorkeeper::TimeLine.new( events.first )
    print "Doorkeepr : %s \n" % timeline.title
  }

  ActiveRecord::Base.transaction do
    search_word.timelines.each{|tl| tl.destroy }
    zussar_compress_json_list.each{|compress_json|
      search_word.timelines.create!( source_type: Timeline::ZUSAAR, data: compress_json )
    }
    connpass_compress_json_list.each{|compress_json|
      search_word.timelines.create!( source_type: Timeline::CONNPASS, data: compress_json )
    }
    qiita_compress_json_list.each{|compress_json|
      search_word.timelines.create!( source_type: Timeline::QIITA, data: compress_json )
    }
    search_word.timelines.create!( source_type: Timeline::ATND, data: atnd_compress_json )
    search_word.timelines.create!( source_type: Timeline::DOORKEEPER, data: doorkeeper_compress_json )
  end

  end_time = Time.now
  puts("処理概要 " + (end_time - start_time).to_s + "s" )
end

begin
  main
rescue => ex
  puts ex.class.to_s
  puts ex.message
  puts ex.backtrace
end