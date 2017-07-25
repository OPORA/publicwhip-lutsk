class DivisionInfo < ApplicationRecord
  belongs_to :division

  def i_to_csv
    CSV.generate do |csv|
      csv << self.class.column_names
      csv << self.class.attributes.values_at(*self.class.column_names)
    end
  end

  def attendance_division
    turnout.to_f / possible_turnout if possible_turnout > 0
  end
  def rebellions_fraction
    rebellions.to_f / turnout if turnout > 0
  end

end
