require_relative './lib/pronounceable_password'
require "pry"
require 'benchmark'

pronounce = PronounceablePassword.new './data/probability.csv'
pronounce.read_probabilities
pass_length = 10
starting_letter = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z).sample

beginning_time1 = Time.now
# most common probability letter
most_common_pronouncable_password = [starting_letter]
while most_common_pronouncable_password.length < pass_length do
  most_common_pronouncable_password << pronounce.most_common_next_letter(most_common_pronouncable_password.last)
end
puts most_common_pronouncable_password.join
while1 = Time.now

beginning_time2 = Time.now
# more random version of above
common_pronouncable_password = [starting_letter]
while common_pronouncable_password.length < pass_length do
  common_pronouncable_password << pronounce.common_next_letter(common_pronouncable_password.last)
end
puts common_pronouncable_password.join
while2 = Time.now

beginning_time3 = Time.now
pass_length.times do
  most_common_pronouncable_password << pronounce.most_common_next_letter(most_common_pronouncable_password.last)
end
times = Time.now
puts common_pronouncable_password.join

puts "While 1 Time elapsed #{(while1 - beginning_time1)*1000} milliseconds"
puts "While 2 Time elapsed #{(while2 - beginning_time2)*1000} milliseconds"
puts "10 Times elapsed #{(times - beginning_time3)*1000} millisecond"
