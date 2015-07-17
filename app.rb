require_relative './lib/pronounceable_password'
pronounce = PronounceablePassword.new './data/probability.csv'
pronounce.read_probabilities
pass_length = 10
starting_letter = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z).sample



# most common probability letter
beginning_time = Time.now
  most_common_pronouncable_password = [starting_letter]
  while most_common_pronouncable_password.length < pass_length do
    most_common_pronouncable_password << pronounce.most_common_next_letter(most_common_pronouncable_password.last)
  end
  puts most_common_pronouncable_password.join
end_time = Time.now

puts "Time elapsed #{ (( end_time - beginning_time ) * 1000).round(2) } milliseconds"


# more random version of above
beginning_time = Time.now
  common_pronouncable_password = [starting_letter]
  while common_pronouncable_password.length < pass_length do
    common_pronouncable_password << pronounce.common_next_letter(common_pronouncable_password.last)
  end
  puts common_pronouncable_password.join
end_time = Time.now

puts "Time elapsed #{ (( end_time - beginning_time ) * 1000).round(2) } milliseconds"


# without the while loop
beginning_time = Time.now
  common_pronouncable_password = [starting_letter]
  (pass_length - 1).times do # (-1 b/c we have a starting letter)
    common_pronouncable_password << pronounce.common_next_letter(common_pronouncable_password.last)
  end
  puts common_pronouncable_password.join
end_time = Time.now

puts "Time elapsed #{ (( end_time - beginning_time ) * 1000).round(2) } milliseconds"


pass_length = 30


# slightly more random
beginning_time = Time.now
  common_pronouncable_password = [starting_letter]
  while common_pronouncable_password.length < pass_length do
    common_pronouncable_password << pronounce.common_next_letter(common_pronouncable_password.last,5)
  end
  puts common_pronouncable_password.join
end_time = Time.now

puts "Time elapsed #{ (( end_time - beginning_time ) * 1000).round(2) } milliseconds"


# without the while loop + slightly more random
beginning_time = Time.now
  common_pronouncable_password = [starting_letter]
  (pass_length - 1).times do
    common_pronouncable_password << pronounce.common_next_letter(common_pronouncable_password.last,5)
  end
  puts common_pronouncable_password.join
end_time = Time.now
puts "Time elapsed #{ (( end_time - beginning_time ) * 1000).round(2) } milliseconds"


# even more sample size
beginning_time = Time.now
  common_pronouncable_password = [starting_letter]
  (pass_length - 1).times do
    common_pronouncable_password << pronounce.common_next_letter(common_pronouncable_password.last,20)
  end
  puts common_pronouncable_password.join
end_time = Time.now
puts "Time elapsed #{ (( end_time - beginning_time ) * 1000).round(2) } milliseconds"
