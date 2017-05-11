class CreateMps < ActiveRecord::Migration[5.1]
  def change
    create_table :mps do |t|
      t.integer :deputy_id
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :faction
      t.integer :okrug
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
