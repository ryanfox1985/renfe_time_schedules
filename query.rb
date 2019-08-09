require 'graphql'
require_relative 'types'
require_relative 'database'

class RenfeQuery < GraphQL::Schema::Object
  description "The query root of this schema"

  field :stops, [Types::Stop], null: false do
    description 'Get all stops of the system'
  end

  def stops
    Stop.all
  end

  field :routes, [Types::Route], null: false do
    description 'Get all routes of the system'
  end

  def routes
    Route.all
  end

  field :trips, [Types::Trip], null: false do
    description 'Get all trips of the system'
  end

  def trips
    Trip.all
  end

  field :stop_times, [Types::StopTime], null: false do
    description 'Get all stop_times of the system'
  end

  def stop_times
    StopTime.all
  end
end
