class Whip < ApplicationRecord
  belongs_to :division
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |d|
        csv << d.attributes.values_at(*column_names)
      end
    end
  end
end
