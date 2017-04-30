class Division < ActiveRecord::Base
  has_many :votes
  has_one :division_info
  has_one :whip
end
