require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
end

require 'require_all'
require_all 'lib'

require 'timecop'
