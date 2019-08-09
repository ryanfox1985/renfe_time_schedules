# frozen_string_literal: true

require 'graphql'

module Types
  class StopTime < GraphQL::Schema::Object
    description 'Resembles a Speaker Object Type'

    field :id, String, null: false
    field :trip_id, String, null: false
    field :departure_time, String, null: false
    field :stop_id, Int, null: false
    field :stop_sequence, Int, null: false
  end

  class Trip < GraphQL::Schema::Object
    description 'Resembles a Speaker Object Type'

    field :id, String, null: false
    field :route_id, String, null: false
    field :service_id, String, null: false
    field :stop_times, [Types::StopTime], 'List of stop_times', null: false
  end

  class Stop < GraphQL::Schema::Object
    description 'Resembles a Speaker Object Type'

    field :id, String, null: false
    field :name, String, null: true
    field :lat, Float, null: true
    field :lat, Float, null: true
    field :stop_times, [Types::StopTime], 'List of stop_times', null: false
  end

  class Route < GraphQL::Schema::Object
    description 'Resembles a Speaker Object Type'

    field :id, String, null: false
    field :short_name, String, null: true
    field :long_name, String, null: true
    field :route_type, Int, null: true
    field :color, String, null: true
    field :trips, [Types::Trip], 'List of trips', null: false
  end
end
