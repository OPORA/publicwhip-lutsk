class AddColumnDateToMpFriend < ActiveRecord::Migration[5.1]
  def change
    add_column :mp_friends, :date_mp_friend, :date
  end
end
