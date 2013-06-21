include JobReactor

job 'sinatra_job' do |args|
  args.merge!(result: 'User is allowed')
end