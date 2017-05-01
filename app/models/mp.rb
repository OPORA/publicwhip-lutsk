class Mp < ActiveRecord::Base
  has_many :votes
  has_many :divisions, through: :votes
  has_one :mp_info, primary_key: :deputy_id, foreign_key: :deputy_id

  def url_name
    self.last_name + "_" + self.first_name
  end
end