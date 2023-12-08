class CreateOccupancies < ActiveRecord::Migration[7.1]
  def change
    create_table :occupancies do |t|
      t.string :resident
      t.datetime :move_in
      t.datetime :move_out
      t.integer :unit_id
    end
  end
end
