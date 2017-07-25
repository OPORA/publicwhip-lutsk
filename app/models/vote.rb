class Vote < ApplicationRecord
  belongs_to :division
  belongs_to :mp, primary_key: :deputy_id, foreign_key: :deputy_id
  def self.find_mp(id)
    find_by(deputy_id: id ).vote
  end
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |d|
        csv << d.attributes.values_at(*column_names)
      end
    end
  end
end
