class Division < ApplicationRecord
  paginates_per 50
  has_many :votes
  has_many :mps, through: :votes
  has_one :division_info
  has_many :whips


  def find_mp(id)
    find_by(deputy_id: id )
  end
  def self.find_by_search_query(query)
    where("number = :query or UPPER(name) like :query_name ", {query: query.to_i, query_name: "%#{query.upcase}%" })
  end
end
