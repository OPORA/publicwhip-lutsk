class CreatePolicyDivisions < ActiveRecord::Migration[5.1]
  def change
    create_table :policy_divisions do |t|
      t.references :policy, foreign_key: true
      t.references :division, foreign_key: true
      t.string :support

      t.timestamps
    end
  end
end
