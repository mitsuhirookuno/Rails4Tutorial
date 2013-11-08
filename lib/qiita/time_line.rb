TimeLine

module Qiita

  class TimeLine < TimeLine

    def started_at
      Time.parse(self.data['created_at'])
    end

    def title
      self.data['title']
    end

  end

end