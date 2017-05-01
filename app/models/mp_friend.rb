class MpFriend < ActiveRecord::Base
  belongs_to :mp, primary_key: :deputy_id, foreign_key: :deputy_id
  belongs_to :mp2, primary_key: :deputy_id, foreign_key: :friend_deputy_id, class_name: Mp
end
