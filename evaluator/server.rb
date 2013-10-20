require 'rubygems'
require 'sinatra/base'
require 'json'
require 'rspec'
require 'rubygems'
require 'pry'

require_relative 'lib/evaluator'

pid_file = File.expand_path('../../tmp/pids/evaluator.pid', __FILE__)
if File.exist?(pid_file)
  old_pid = File.read(pid_file)
  Process.kill('TERM', old_pid.to_i) rescue nil
  sleep 0.5
end

File.open(pid_file, 'w'){ |f| f.write(Process.pid) }

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

