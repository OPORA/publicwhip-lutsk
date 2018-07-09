class Policy < ApplicationRecord
  has_many :policy_divisions
  has_many :policy_person_distances
  def self.find_by_search_query(query)
    where("UPPER(name) like :query_name ", { query_name: "%#{query.upcase}%" })
  end
end
