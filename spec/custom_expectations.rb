require 'rspec/expectations'

RSpec::Matchers.define :be_one_of do |expected|
  match do |actual|
    # puts "#{expected} #{actual}"
    expected.include?(actual)
  end
end
