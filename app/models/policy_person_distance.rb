class PolicyPersonDistance < ApplicationRecord
  belongs_to :policy
  belongs_to :mp, primary_key: :deputy_id, foreign_key: :deputy_id, class_name: Mp
end
