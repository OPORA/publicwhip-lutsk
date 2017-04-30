class Division < ActiveRecord::Base
  has_many :votes
  has_many :mps, through: :votes
  has_one :division_info
  has_many :whips
end
