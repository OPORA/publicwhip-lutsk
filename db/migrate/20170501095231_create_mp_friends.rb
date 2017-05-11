class CreateMpFriends < ActiveRecord::Migration[5.1]
  def change
    create_table :mp_friends do |t|
      t.integer :deputy_id
      t.integer :friend_deputy_id
      t.integer :count

      t.timestamps null: false
    end
    add_foreign_key :mp_friends, :mps, column: :deputy_id, primary_key: :deputy_id
    add_foreign_key :mp_friends, :mps, column: :friend_deputy_id, primary_key: :deputy_id
  end
end
