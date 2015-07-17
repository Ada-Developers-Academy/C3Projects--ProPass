require_relative './lib/pronounceable_password'

pronounce = PronounceablePassword.new './data/probability.csv'

pass_length = 10
starting_letter = ('a'..'z').to_a.sample

# most common probability letter
most_common_pronouncable_password = [starting_letter]
while most_common_pronouncable_password.length < pass_length do
  most_common_pronouncable_password << pronounce.most_common_next_letter(most_common_pronouncable_password.last)
end
puts most_common_pronouncable_password.join

# more random version of above
common_pronouncable_password = [starting_letter]
while common_pronouncable_password.length < pass_length do
  common_pronouncable_password << pronounce.common_next_letter(common_pronouncable_password.last)
end
puts common_pronouncable_password.join
