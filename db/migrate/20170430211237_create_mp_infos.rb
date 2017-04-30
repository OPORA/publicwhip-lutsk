class CreateMpInfos < ActiveRecord::Migration
  def change
    create_table :mp_infos do |t|
      t.integer :deputy_id
      t.integer :rebellions
      t.integer :not_voted
      t.integer :absent
      t.integer :against
      t.integer :aye_voted
      t.integer :abstain
      t.integer :votes_possible
      t.integer :votes_attended

      t.timestamps null: false
    end
    add_foreign_key :mp_infos, :mps, column: :deputy_id, primary_key: :deputy_id
  end
end
