class Division < ActiveRecord::Base
  paginates_per 50
  has_many :votes
  has_many :mps, through: :votes
  has_one :division_info
  has_many :whips


  def find_mp(id)
    find_by(deputy_id: id )
  end
end
