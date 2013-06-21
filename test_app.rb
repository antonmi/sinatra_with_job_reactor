require 'pry'
require "bundler"
Bundler.setup

require 'job_reactor'

JR.wait_em_and_run do
  JR.start_distributor('localhost', 5000)
end

EM.run do
  puts 'EM is running'

  EM::PeriodicTimer.new(1) do
    JR.enqueue 'test_job', { a: 1 }
  end

  EM::Timer.new(10) { EM.stop }
end


