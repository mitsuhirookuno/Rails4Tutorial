TimeLine

module Doorkeeper

  class TimeLine < TimeLine

    def started_at
      Time.parse(self.data['event']['starts_at'])
    end

    def title
      self.data['event']['title']
    end

  end

end