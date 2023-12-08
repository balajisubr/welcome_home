class AddUnitIdToOccupancies < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :occupancies, :units, column: :unit_id
  end
end
