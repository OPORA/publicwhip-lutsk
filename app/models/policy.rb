class Policy < ApplicationRecord
  has_many :policy_divisions
  has_many :policy_person_distances
  validates :name, presence: true
  validates :description, presence: true
  has_paper_trail
  def self.find_by_search_query(query)
    where("UPPER(name) like :query_name ", { query_name: "%#{query.upcase}%" })
  end
  def self.filter_polices(param)
    if param.nil?
      max = 100
      min = 95
    elsif param =="2"
      max = 95
      min = 85
    elsif  param =="3"
      max = 85
      min = 60
    elsif  param =="4"
      max = 60
      min = 40
    elsif  param =="5"
      max = 40
      min = 15
    elsif param =="6"
      max = 15
      min = 0
    end
    return { min: min, max: max}
  end
end
