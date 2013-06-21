require 'sinatra/base'
require 'pry'
require "bundler"
Bundler.setup

require 'job_reactor'


JR.run do
  JR.start_distributor('localhost', 5000)
end

class SinatraApp < Sinatra::Base
  set :server, :puma
  set :logging, true

  @@visits = []
  get '/' do
    ip = request.ip
    success = Proc.new do |args|
      @@visits << { ip => args[:result] }
    end

    JR.enqueue('sinatra_job', {ip: ip}, {}, success)
    @@visits.to_s
  end

  run!
end