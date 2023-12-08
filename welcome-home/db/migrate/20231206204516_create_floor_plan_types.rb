class CreateFloorPlanTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :floor_plan_types do |t|
      t.string :floor_plan_type
      t.index :floor_plan_type, unique: true
    end
  end
end
