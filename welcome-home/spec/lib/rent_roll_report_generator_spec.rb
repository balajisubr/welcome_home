require './spec/spec_helper.rb'
require './spec/rails_helper.rb'
require './lib/rent_roll_report_generator.rb'
RSpec.describe RentRollReportGenerator do
  let(:data_file_path) { '../assets/units-and-residents.csv' }
  let(:as_of) { Date.new(2019,6,2) }
  before :each do
    described_class.generate_data_from_csv(data_file_path)
  end

  describe '.generate_data_from_csv' do
    it 'generates correct data from csv' do
      expect(Unit.count).to eq(8)
      expect(FloorPlanType.count).to eq(2)
      #Occupancy count is not predictable
      expect(Occupancy.count > 0).to be true
    end
  end

  describe '.generate' do
    it 'generates rent roll report' do
      report = described_class.generate
      expect(report).to eq(
        [[1, 'Studio', 'John Smith', 'current', '2021-01-01', ''],
         [1, 'Studio', 'Sally Carol', '', '2019-06-01', '2020-12-15'],
         [2, 'Suite', 'Sarah', 'current', '2021-03-01', ''],
         [3, 'Suite', '', '', '', ''],
         [4, 'Suite', '', '', '', ''],
         [5, 'Suite', 'Teddy', '', '', ''],
         [10, 'Studio', '', '', '', ''],
         [11, 'Studio', '', '', '', ''],
         [12, 'Studio', '', '', '', '']]
      )
    end
  end

  describe '.vacant_units' do
    let(:generator) { described_class.new(as_of) }
    let(:units) do
      [Unit.find_by(unit_number: 3),
       Unit.find_by(unit_number: 4),
       Unit.find_by(unit_number: 5),
       Unit.find_by(unit_number: 10),
       Unit.find_by(unit_number: 11),
       Unit.find_by(unit_number: 12)
      ] 
    end
    it 'returns correct units' do
      expect(generator.vacant_units.sort).to eq(units.sort)
    end
  end
  
  describe '.occupied_units' do
    let(:generator) { described_class.new(as_of) }
    let(:units) do
      [
       Unit.find_by(unit_number: 1)
      ] 
    end
    it 'returns correct units' do
      expect(generator.occupied_units.sort).to eq(units.sort)
    end
  end  
  
  describe '.leased_units' do
    let(:generator) { described_class.new(as_of) }
    let(:units) do
      [Unit.find_by(unit_number: 1),
       Unit.find_by(unit_number: 2)
      ] 
    end
    it 'returns correct units' do
      expect(generator.leased_units.sort).to eq(units.sort)
    end
  end  
end
