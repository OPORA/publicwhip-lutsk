class Vote < ActiveRecord::Base
  belongs_to :division
  belongs_to :mp, primary_key: :deputy_id, foreign_key: :deputy_id
  def self.find_mp(id)
    find_by(deputy_id: id ).vote
  end
end
