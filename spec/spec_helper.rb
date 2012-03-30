require 'rubygems'
require 'spork'

Spork.prefork do

end

Spork.each_run do

end

require 'rubygems'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy-2-3-12/config/environment.rb",  __FILE__)
require 'spec/autorun'
require 'spec/rails'
$:.unshift File.expand_path("../", __FILE__) unless $:.include?(File.expand_path("../", __FILE__))

Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

Spec::Runner.configure do |config|

  # support flash.now
  config.before(:each, :behaviour_type => :controller) do
    @controller.instance_eval { flash.stub!(:sweep) }
  end
end

at_exit do
  FileUtils.rm_rf Dir.glob(File.expand_path("../dummy-2-3-12/db/*.tct", __FILE__))
end
