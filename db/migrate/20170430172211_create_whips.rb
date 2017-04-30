class CreateWhips < ActiveRecord::Migration
  def change
    create_table :whips do |t|
      t.integer :division_id
      t.string :party
      t.integer :aye_votes
      t.integer :no_votes
      t.integer :absent
      t.integer :against
      t.integer :abstain
      t.string :whip_guess

      t.timestamps null: false
    end
    add_foreign_key :whips, :divisions
  end
end
