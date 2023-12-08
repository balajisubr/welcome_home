require 'csv'
CURRENT_STATUS='current'
FUTURE_STATUS='future'

class RentRollReportGenerator
  class << self
    def generate_data_from_csv(data_file_path)
      csv_text = File.read(data_file_path)
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
        unit_info = row[0]
        floor_plan_info = row[1]
        resident = row[2]
        move_in = !row[3].nil? ? Date.strptime(row[3], '%m/%d/%Y') : nil
        move_out = !row[4].nil? ? Date.strptime(row[4], '%m/%d/%Y') : nil
        floor_plan_type = FloorPlanType.find_by(floor_plan_type: floor_plan_info)
        if floor_plan_type.nil?
          floor_plan_type = FloorPlanType.create(floor_plan_type: floor_plan_info)
        end

        unit = Unit.find_by(unit_number: unit_info)
        if unit.nil?
          unit = Unit.create(unit_number: unit_info, floor_plan_type_id: floor_plan_type.id)
        end

        Occupancy.create(
          unit_id: unit.id,
          resident: resident,
          move_in: move_in,
          move_out: move_out
        )
      end
		end

    def generate(as_of: Date.today)
      new(as_of).generate
    end
  end

  attr_accessor :as_of

  def initialize(as_of = Date.today)
    self.as_of = as_of
  end

  def generate 
    Occupancy.all.sort_by{ |o| o.unit.unit_number }.map do |occ|
      unit = occ.unit
      [unit.unit_number,
       unit.floor_plan_type.floor_plan_type,
       occ.resident || '',
       occupancy_status(occ) || '',
       occ.move_in&.to_date.to_s,
       occ.move_out&.to_date.to_s
      ]
    end 
  end

  def vacant_units
    Unit.all.select do |unit|
      occupancies = Occupancy.where(unit_id: unit.id)
      occupancies.map { |o| occupancy_status(o) }.compact.uniq.empty?
    end
  end

  def occupied_units
    units = []
    Occupancy.leased.select do |occ|
      units << occ.unit if occupancy_status(occ) == CURRENT_STATUS
    end
    units.uniq
  end
 
  def leased_units
    units = []
    Occupancy.leased.select do |occ|
      units << occ.unit if occupancy_status(occ).present?
    end
    units.uniq
  end

  private

  def occupancy_status(occupancy)
    # Empty occupancy_status indicates past occupancy or no occupancy
    return unless occupancy.move_in

    return FUTURE_STATUS if occupancy.move_in > as_of

    return CURRENT_STATUS if (occupancy.move_out.nil?) || (occupancy.move_out > as_of)
  end
end
