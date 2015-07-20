require_relative './lib/pronounceable_password'
require 'benchmark'
pronounce = PronounceablePassword.new './data/probability.csv'
pronounce.read_probabilities
pass_length = 10
starting_letter = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z).sample

# most common probability letter
most_common_pronouncable_password = [starting_letter]
while most_common_pronouncable_password.length < pass_length do
  most_common_pronouncable_password << pronounce.most_common_next_letter(most_common_pronouncable_password.last)
end
puts most_common_pronouncable_password.join

# refactored
most_common_pronouncable_password = [starting_letter]
(pass_length - 1).times do
  most_common_pronouncable_password << pronounce.most_common_next_letter(most_common_pronouncable_password.last)
end
puts most_common_pronouncable_password.join

# more random version of above
common_pronouncable_password = [starting_letter]
while common_pronouncable_password.length < pass_length do
  common_pronouncable_password << pronounce.common_next_letter(common_pronouncable_password.last)
end
puts common_pronouncable_password.join

# refactored
common_pronouncable_password = [starting_letter]
(pass_length - 1).times do
  common_pronouncable_password << pronounce.common_next_letter(common_pronouncable_password.last)
end
puts common_pronouncable_password.join


# Testing efficiency
time1 = Benchmark.realtime do
  most_common_pronouncable_password = [starting_letter]
  while most_common_pronouncable_password.length < pass_length do
    most_common_pronouncable_password << pronounce.most_common_next_letter(most_common_pronouncable_password.last)
  end
  puts most_common_pronouncable_password.join
end

puts """
Time elapsed for most common pronounceable password with while loop:
#{ time1 * 1000 } milliseconds.
"""

time2 = Benchmark.realtime do
  most_common_pronouncable_password = [starting_letter]
  (pass_length - 1).times do
    most_common_pronouncable_password << pronounce.most_common_next_letter(most_common_pronouncable_password.last)
  end
  puts most_common_pronouncable_password.join
end

puts """
Time elapsed for most common pronounceable password with .times:
#{ time2 * 1000 } milliseconds.
"""


time3 = Benchmark.realtime do
  common_pronouncable_password = [starting_letter]
  while common_pronouncable_password.length < pass_length do
    common_pronouncable_password << pronounce.common_next_letter(common_pronouncable_password.last)
  end
  puts common_pronouncable_password.join
end

puts """
Time elapsed for common pronounceable password with while loop:
#{ time3 * 1000 } milliseconds.
"""

time4 = Benchmark.realtime do
  common_pronouncable_password = [starting_letter]
  (pass_length - 1).times do
    common_pronouncable_password << pronounce.common_next_letter(common_pronouncable_password.last)
  end
  puts common_pronouncable_password.join
end

puts """
Time elapsed for common pronounceable password with .times:
#{ time4 * 1000 } milliseconds.
"""
