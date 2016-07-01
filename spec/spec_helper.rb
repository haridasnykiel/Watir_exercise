require 'rspec'
require 'pry'
require 'watir'
require 'yaml'
# require './application'

RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.formatter = :documentation
end
