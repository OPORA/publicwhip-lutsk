class MpInfo < ApplicationRecord
  belongs_to :mp, primary_key: :deputy_id, foreign_key: :deputy_id
  def rebellions_fraction
    rebellions.to_f / votes_attended if votes_attended > 0
  end
  def attendance_fraction
    votes_attended.to_f / votes_possible if votes_possible > 0
  end
end
