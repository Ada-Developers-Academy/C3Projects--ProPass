require_relative './lib/pronounceable_password'
require "pry"
pronounce = PronounceablePassword.new('./data/probability.csv')
pronounce.read_probabilities

# pass_length = 10
remaining_letters = 9
starting_letter = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z).sample

# ____ most common probability letter ____
most_common_pronouncable_password = [starting_letter]
(remaining_letters).times do
  most_common_pronouncable_password << pronounce.most_common_next_letter(most_common_pronouncable_password.last)
end
puts most_common_pronouncable_password.join

# ____ more random version of above ____
common_pronouncable_password = [starting_letter]
(remaining_letters).times do
  common_pronouncable_password << pronounce.common_next_letter(common_pronouncable_password.last)
end
puts common_pronouncable_password.join


# ____ most common probability letter ____

# most_common_pronouncable_password = [starting_letter]
# while most_common_pronouncable_password.length < pass_length do
#   most_common_pronouncable_password << pronounce.most_common_next_letter(most_common_pronouncable_password.last)
# end
# puts most_common_pronouncable_password.join

# ____ more random version of above ____
# common_pronouncable_password = [starting_letter]
# while common_pronouncable_password.length < pass_length do
#   common_pronouncable_password << pronounce.common_next_letter(common_pronouncable_password.last)
# end
# puts common_pronouncable_password.join
