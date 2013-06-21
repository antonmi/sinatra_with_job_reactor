require 'job_reactor'

JR.run! do
  JR.start_node({
                    storage: 'memory_storage',
                    name: 'node1',
                    server: ['localhost', 2001],
                    distributors: [['localhost', 5000]]
                })
end