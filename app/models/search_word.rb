class SearchWord < ActiveRecord::Base

  has_many :timelines

  attr_accessible :name, :number

end
