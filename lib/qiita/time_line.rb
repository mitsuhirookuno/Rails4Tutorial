TimeLine

module Qiita

  class TimeLine < TimeLine

    def started_at
      Time.parse(self.data['created_at'])
    end

    def started_at
      Time.parse(self.data['created_at'])
    end

    def title
      self.data['title']
    end

    def link
      self.data['url']
    end

    def inner_link
      self.link
      '/qiita/items/%s' % self.data['uuid']
    end

  end

end