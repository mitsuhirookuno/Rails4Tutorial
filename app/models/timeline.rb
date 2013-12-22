class Timeline < ActiveRecord::Base

  belongs_to :search_word

  attr_accessible :source_type, :data

  QIITA = 1
  ZUSAAR = 2
  CONNPASS = 3
  ATND = 4
  DOORKEEPER = 5

end
