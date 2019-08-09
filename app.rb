# frozen_string_literal: true

require 'pry'
require 'sinatra'
require 'graphql'
require 'rack/contrib'
require_relative 'schema'

class RenfeApp < Sinatra::Base
  use Rack::PostBodyContentTypeParser

  get '/version' do
    { version: 1.0 }.to_json
  end

  post '/graphql' do
    RenfeSchema.execute(
      params[:query],
      variables: params[:variables],
      context: { current_user: nil }
    ).to_json
  end
end
