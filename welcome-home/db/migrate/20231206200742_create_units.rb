class CreateUnits < ActiveRecord::Migration[7.1]
  def change
    create_table :units do |t|
      t.integer :unit_number
      t.index :unit_number, unique: true
      t.integer :floor_plan_type_id
    end
  end
end
