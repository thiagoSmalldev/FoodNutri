every 1.day, at: '4:00 am' do
  runner 'ImportDataJob.perform_now'
end
