class DivisionInfo < ApplicationRecord
  belongs_to :division
  def attendance_division
    turnout.to_f / possible_turnout if possible_turnout > 0
  end
end
