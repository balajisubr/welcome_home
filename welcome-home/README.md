# README

* Ruby version - 2.7.1

* Rails version - 7.1.2

* Database - Postgres

* Database schema
  * units table - lists all the units in the community and corresponds to Unit rails model
    id - bigint (primary key)
    unit_number - int
    floor_plan_type_id - int(references id of floor_plan_types) 
  * floor_plan_types table - lists all floor plan types and corresponds to FloorPlanType rails model
    id - bigint (primary key)
    floor_plan_type - string
  * occupancies - lists all the occupancies of units, one for each row in csv and corresponds to Occupancy rails model
    id - bigint (primary key)
    resident - string
    move_in - datetime
    move_out - datetime
    unit_id - int(references id of units)

* Database initialization
  `bundle exec rake db:create db:migrate`

* Rent roll report generator
  * It is included in 'lib/rent_roll_report_generator.rb'
  * The data first needs to be loaded using a CSV
      `RentRollReportGenerator.generate_data_from_file(<PATH TO CSV>)`
  * The date as of which it needs to be run can be supplied while creating a new object
     `generator = RentRollReportGenerator.new(Date.new(2016,6,2))`
  * The generate method generates the report
     `generator.generate`
  * To find vacant units
     `generator.vacant_units`
  * To find occupied units
     `generator.occupied_units`
  * To find leased units
     `generator.leased_units`

* Tests
  * Basic units tests have been written for the RentRollReportGenerator
  * They are located in spec/lib/rent_roll_report_generator_spec.rb
  * They can be run using
     `bundle exec rspec spec/lib/rent_roll_report_generator_spec.rb`
