class CreateDivisionInfos < ActiveRecord::Migration
  def change
    create_table :division_infos do |t|
      t.integer :division_id
      t.integer :aye_votes
      t.integer :no_votes
      t.integer :absent
      t.integer :against
      t.integer :abstain
      t.integer :possible_turnout
      t.integer :turnout
      t.integer :rebellions

      t.timestamps null: false
    end
    add_foreign_key :division_infos, :divisions
  end
end
