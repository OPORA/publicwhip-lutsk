class CreateVoteFactions < ActiveRecord::Migration[5.1]
  def change
    create_table :vote_factions do |t|
      t.string :faction
      t.date :date
      t.integer :vote_aye

      t.timestamps
    end
  end
end
