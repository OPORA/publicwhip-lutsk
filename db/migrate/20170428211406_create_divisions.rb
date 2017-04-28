class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.date :date
      t.integer :number
      t.text :name
      t.string :clock_time
      t.string :result

      t.timestamps null: false
    end
  end
end
