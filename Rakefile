task :default => :test

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test" 
  t.test_files = FileList['test/unit/*.rb','test/request/*.rb']
  t.verbose = true
end
