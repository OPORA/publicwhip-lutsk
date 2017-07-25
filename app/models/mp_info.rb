class MpInfo < ApplicationRecord
  belongs_to :mp, primary_key: :deputy_id, foreign_key: :deputy_id
  def rebellions_fraction
    rebellions.to_f / votes_attended if votes_attended > 0
  end
  def attendance_fraction
    votes_attended.to_f / votes_possible if votes_possible > 0
  end
  def self.mp_to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |mp|
        csv << mp.attributes.values_at(*column_names)
      end
    end
  end
end
