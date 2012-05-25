require 'bundler'
Bundler::GemHelper.install_tasks

#require 'rake'
require 'rake/testtask'

# Run the test with 'rake' or 'rake test'
desc 'Default: run resourceful_parenting unit tests.'
task :default => :test

desc 'Test the resourceful_parenting plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib' << 'test'
  t.pattern = 'test/**/test_*.rb'
  t.verbose = false
end

# Run the rdoc task to generate rdocs for this gem
require 'rdoc/task'
RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "resourceful_parenting"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
