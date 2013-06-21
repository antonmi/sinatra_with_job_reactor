require 'pry'
require "bundler"
Bundler.setup
require 'job_reactor'

JR.config[:logger_method] = nil
JR.run! do
  JR.start_node({
                    storage: 'redis_storage',
                    name: 'node1',
                    server: ['localhost', 2001],
                    distributors: [['localhost', 5000]]
                })
end