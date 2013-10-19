require 'rubygems'
require 'sinatra/base'
require 'json'
require 'rspec'
require 'rubygems'
require 'pry'
require_relative 'lib/evaluator'

module Riddlr
  class Server < Sinatra::Base

    post '/verifications' do
      content_type :json
      data = JSON.parse(request.body.read)

      evaluator = Riddlr::Evaluator.new(data['code'], data['expectations'])

      evaluator.run.to_json
    end

    run! if app_file == $0
  end
end

