require_relative './lib/pronounceable_password'
require 'benchmark'

time1 = Benchmark.measure do
  1000.times do
    pronounce = PronounceablePassword_One.new('./data/probability.csv')
    pronounce.read_probabilities
    pass_length = 5
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
  end
end


time2 = Benchmark.measure do
  1000.times do
    pronounce = PronounceablePassword_Two.new('./data/probability.csv')
    pronounce.read_probabilities
    pass_length = 5
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
  end
end

time3 = Benchmark.measure do
  1000.times do
    pronounce = PronounceablePassword_Three.new('./data/probability.csv')
    pronounce.read_probabilities
    pass_length = 5
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
  end
end

puts "Option 1: "
puts time1

puts "Option 2: "
puts time2

puts "Option 3: "
puts time3

# # BENCHMARKS -----------------------------------------------------------------

# # 100 times, pass_length: 10
# Option 1:
#   2.090000   0.030000   2.120000 (  2.130097)
# Option 2:
#   1.330000   0.020000   1.350000 (  1.365363)
# Option 3:
#   1.240000   0.020000   1.260000 (  1.280186)

# # 100 times, pass_length: 100
# Option 1:
#  11.620000   0.160000  11.780000 ( 11.988374)
# Option 2:
#   1.540000   0.020000   1.560000 (  1.588219)
# Option 3:
#   1.290000   0.020000   1.310000 (  1.330304)
  # # REPEAT
  # Option 1:
  #  10.870000   0.130000  11.000000 ( 11.120919)
  # Option 2:
  #   1.410000   0.020000   1.430000 (  1.438920)
  # Option 3:
  #   1.280000   0.020000   1.300000 (  1.308249)

# # 10 times, pass_length: 10
# Option 1:
#   0.200000   0.010000   0.210000 (  0.207012)
# Option 2:
#   0.120000   0.000000   0.120000 (  0.125751)
# Option 3:
#   0.120000   0.000000   0.120000 (  0.124204)

# # 10 times, pass_length: 100
# Option 1:
#   1.110000   0.020000   1.130000 (  1.131144)
# Option 2:
#   0.130000   0.000000   0.130000 (  0.142227)
# Option 3:
#   0.140000   0.000000   0.140000 (  0.135014)

# 10 times, pass_length: 1000
# Option 1:
#   9.620000   0.060000   9.680000 (  9.734031)
# Option 2:
#   0.290000   0.000000   0.290000 (  0.292082)
# Option 3:
#   0.140000   0.000000   0.140000 (  0.141338)
  # # REPEAT
  # Option 1:
  #   9.390000   0.050000   9.440000 (  9.491011)
  # Option 2:
  #   0.270000   0.000000   0.270000 (  0.275324)
  # Option 3:
  #   0.140000   0.010000   0.150000 (  0.137777)

# 1_000 times, pass_length: 5
# Option 1:
#  15.050000   0.250000  15.300000 ( 15.458569)
# Option 2:
#  12.750000   0.200000  12.950000 ( 13.113109)
# Option 3:
#  12.400000   0.240000  12.640000 ( 12.818280)
