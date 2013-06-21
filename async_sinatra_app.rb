require 'sinatra/async'
require 'pry'
require "bundler"
Bundler.setup

require 'job_reactor'

JR.wait_em_and_run do
  JR.start_distributor('localhost', 5000)
end

class AsyncTest < Sinatra::Base
  register Sinatra::Async

  set :threaded, false
  set :server, :thin

  @@visits = []

  aget '/' do
    ip = request.ip
    success = Proc.new do |args|
      @@visits << { ip => args[:result] }
      body(@@visits.to_s)
    end

    JR.enqueue('sinatra_job', {ip: ip}, {}, success)
  end

  run!
end