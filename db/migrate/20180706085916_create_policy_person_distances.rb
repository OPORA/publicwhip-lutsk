class CreatePolicyPersonDistances < ActiveRecord::Migration[5.1]
  def change
    create_table :policy_person_distances do |t|
      t.references :policy, foreign_key: true
      t.integer :deputy_id
      t.integer :assume, null: false, default: 0
      t.integer :possible, null: false, default: 0
      t.integer :support, null: false, default: 0

      t.timestamps
    end
  end
end
