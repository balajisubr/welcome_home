class Occupancy < ApplicationRecord
  belongs_to :unit
  scope :leased, -> { where("resident IS NOT NULL") }
end
