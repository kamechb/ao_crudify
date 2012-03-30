require 'rake/testtask'
require 'spec/rake/spectask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the ao_locked gem.'
Spec::Rake::SpecTask.new(:test) do |t|
	t.spec_files = FileList['spec/**/*_spec.rb']
	t.spec_opts = ['-c','-f','nested']
end
