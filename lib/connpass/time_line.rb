TimeLine

module Connpass

  class TimeLine < TimeLine

    def started_at
      Time.parse(self.data['started_at'])
    end

    def title
      self.data['title']
    end

    def link
      self.data['event_url']
    end

    def inner_link
      '/connpass/events/%s' % self.data['event_id']
    end

  end

end