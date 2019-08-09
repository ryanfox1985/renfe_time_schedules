require 'graphql'
require_relative 'query'

class RenfeSchema < GraphQL::Schema
  query RenfeQuery
end
