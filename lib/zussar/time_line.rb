TimeLine

module Zussar

  class TimeLine < TimeLine
    # ended_at
    def started_at
      Time.parse(self.data.started_at)
    end

    def ended_at
      Time.parse(self.data.ended_at)
    end

    def title
      self.data.title
    end

    def link
      self.data.event_url
    end

    def inner_link
      '/zussar/events/%s' % self.data.event_id
    end

  end

end