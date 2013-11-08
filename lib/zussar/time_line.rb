TimeLine

module Zussar

  class TimeLine < TimeLine

    def started_at
      Time.parse(self.data.started_at)
    end

    def title
      self.data.title
    end

  end

end