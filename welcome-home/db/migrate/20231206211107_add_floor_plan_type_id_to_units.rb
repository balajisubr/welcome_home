class AddFloorPlanTypeIdToUnits < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :units, :floor_plan_types, column: :floor_plan_type_id
  end
end
