class PolicyDivision < ApplicationRecord
  belongs_to :policy
  belongs_to :division
  validates :division_id, presence: true, uniqueness: true
end
