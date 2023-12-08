# WelcomeHome Developer Interview

WelcomeHome is a CRM designed for sales teams at senior living communities.

## Exercise Overview

One use-case of WelcomeHome is to track which residents are in which units, as
it's useful for sales counselors to know which units are available to sell/rent.
In this exercise, you'll work with data representing occupancy / unit
availability information. A common industry term for this collection of
information is a "rent roll," which lists units, residents, and their lease
information.

## Guidance and Expectations

- This exercise is designed to take about 1 hour. If you are taking
  substantially longer, feel free to stop. We'll still have plenty to talk
  about!
- Develop the exercise within a Rails app using Test-Driven Development
- Focus on the business/domain logic (no controllers/views necessary)
- Share your solution via GitHub, or send over a tarball of your git repo
- Be ready to discuss your solution, exercise key behavior via rails console,
  and pair on the code

## User Story

As a user (who knows how to use rails console), I want to be able to load a CSV
file containing my community's unit and resident information so that I can
view a rent roll report and query key statistics in order to have a better
understanding of the state of my community.

## Specs / Additional Information

### Data File

The data file is a CSV that looks like [./assets/units-and-residents.csv](./assets/units-and-residents.csv).

### Rent Roll Report

A rent roll report lists units in order by unit number, and includes the
following data:

- Unit number
- Floor Plan name
- Resident name
- Resident status (current or future)
- Move in date
- Move out date

A rent roll is run for a given date. It includes current and future
residents, as well as vacant units.

This rent roll report will be viewed in the rails console, it can be an array of
arrays or a formatted string.

### Key Statistics

For a given date, users want to see the number of:

- Vacant units
- Occupied units
- Leased units (the count of the unique set of occupied units and
  units with future residents)

### Other Notes

- Data should be persisted to a database, and read from the database to generate
  the rent roll and key statistics
