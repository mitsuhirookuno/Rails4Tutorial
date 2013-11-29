TimeLine

module Doorkeeper

  class TimeLine < TimeLine

    def started_at
      Time.parse(self.data['event']['starts_at'])
    end

    def ended_at
      Time.parse(self.data['event']['ends_at'])
    end

    def title
      self.data['event']['title']
    end

    def link
      self.data['event']['public_url']
    end

    def inner_link
      params =[
          self.data['event']['id'],
          self.data['event']['starts_at'],
          self.data['event']['ends_at']
      ]
      '/doorkeeper/events/%s?ends_at=%s&starts_at=%s' % params
    end

  end

end