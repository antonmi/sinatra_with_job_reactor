include JobReactor

job 'sinatra_job' do |args|
  ip = args[:ip]
  args.merge!(result: 'User is allowed')
end