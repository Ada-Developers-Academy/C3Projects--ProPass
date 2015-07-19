require_relative './lib/pronounceable_password'
pronounce = PronounceablePassword.new './data/probability.csv'
pronounce.read_probabilities
pass_length = 10
all_letters = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
starting_letter = all_letters.sample

# most common probability letter
puts pronounce.most_common_pronouncable_password(starting_letter, pass_length)

# more random version of above
puts pronounce.common_pronouncable_password(starting_letter, pass_length)

# more random versions
puts pronounce.common_pronouncable_password(starting_letter, pass_length, 5)
puts pronounce.common_pronouncable_password(starting_letter, pass_length, 10)
puts pronounce.common_pronouncable_password(starting_letter, 15, 10)

puts "Most Common Pronoucable Passwords:"
all_letters.each do |letter|
  puts letter + " = " + pronounce.most_common_pronouncable_password(letter, pass_length)
end
