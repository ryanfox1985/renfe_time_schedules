# frozen_string_literal: true

require 'csv'
require 'pry'
require_relative 'database'

# Define a minimal database schema
ActiveRecord::Schema.define do
  create_table :stops, force: true do |t|
    t.string :name
    t.decimal :lat
    t.decimal :lon
  end

  create_table :routes, force: true, id: :string do |t|
    t.string :short_name
    t.string :long_name
    t.integer :route_type
    t.string :color
  end

  create_table :trips, force: true, id: :string do |t|
    t.string :route_id
    t.string :service_id
  end

  create_table :stop_times, force: true do |t|
    t.string :trip_id
    # t.time :arrival_time
    t.time :departure_time
    t.integer :stop_id
    t.integer :stop_sequence
  end
end

def load_stops!(csv_options)
  Stop.destroy_all

  print 'Loading stops... '
  CSV.foreach('fomento_transit/stops.txt', csv_options) do |row|
    Stop.create!(id: row[0], name: row[1], lat: row[2], lon: row[3])
  end

  puts "#{Stop.count} loaded."
end
class Stop < ActiveRecord::Base
  has_many :stop_times
end

class Route < ActiveRecord::Base
  has_many :trips
end

class Trip < ActiveRecord::Base
  belongs_to :route
  has_many :stop_times
end

class StopTime < ActiveRecord::Base
  belongs_to :trip
  belongs_to :stop
end
def load_routes!(csv_options)
  Route.destroy_all

  print 'Loading routes... '
  CSV.foreach('fomento_transit/routes.txt', csv_options) do |row|
    Route.create!(id: row[0], short_name: row[1], long_name: row[2],
                  route_type: row[3], color: row[4])
  end

  puts "#{Route.count} loaded."
end

def load_trips!(csv_options)
  Trip.destroy_all

  print 'Loading trips... '
  CSV.foreach('fomento_transit/trips.txt', csv_options) do |row|
    Trip.create!(route_id: row[0], service_id: row[1], id: row[2])
  end

  puts "#{Trip.count} loaded."
end

def load_stop_times!(csv_options)
  StopTime.destroy_all

  print 'Loading stop_times... '
  CSV.foreach('fomento_transit/stop_times.txt', csv_options) do |row|
    StopTime.create!(trip_id: row[0], departure_time: row[2], stop_id: row[3],
                     stop_sequence: row[4])
  end

  puts "#{StopTime.count} loaded."
end

def reload_data!(csv_options = {})
  load_stops!(csv_options)
  load_routes!(csv_options)
  load_trips!(csv_options)
  load_stop_times!(csv_options)
end

reload_data!(col_sep: ',', headers: true)

Pry.start
