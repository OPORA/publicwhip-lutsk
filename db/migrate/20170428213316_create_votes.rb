class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :division_id
      t.integer :deputy_id
      t.string :vote

      t.timestamps null: false
    end
  end
end
