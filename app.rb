require_relative './lib/pronounceable_password'
require 'benchmark'

pronounce = PronounceablePassword.new('./data/probability.csv')
pronounce.prep_database
pass_length = 10
starting_letter = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z).sample

# most common probability letter
most_common_pronouncable_password = [starting_letter]
while most_common_pronouncable_password.length < pass_length do
  most_common_pronouncable_password << pronounce.most_common_next_letter(most_common_pronouncable_password.last)
end
print "Most probable password: "
puts most_common_pronouncable_password.join

# more random version of above
common_pronouncable_password = [starting_letter]
while common_pronouncable_password.length < pass_length do
  common_pronouncable_password << pronounce.common_next_letter(common_pronouncable_password.last)
end
print "Random(ish) password: "
puts common_pronouncable_password.join

# without a while loop
  # NOTE: I thought about using recursion,
  # but that seemed unnecessarily complicated,
  # and not like this was a good use for it?
previous_letter = starting_letter
pro_pass = starting_letter
(pass_length - 1).times do
  previous_letter = pronounce.common_next_letter(previous_letter)
  pro_pass += previous_letter
end
print "Random(ish) password without a while loop: "
puts pro_pass
