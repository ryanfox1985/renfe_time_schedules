# frozen_string_literal: true

require 'active_record'
require 'sqlite3'

# Define database connection
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  # database: ':memory:'
  database: 'train_database.db'
)

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
