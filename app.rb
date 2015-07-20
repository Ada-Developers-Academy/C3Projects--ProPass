require_relative './lib/pronounceable_password'
require 'benchmark'
require 'awesome_print'

TIME_FACTORS = [100, 1000, 10_000, 100_000, 1_000_000]

hash_pronounce =  PronounceablePasswordWithAGiantHash.new './data/probability.csv'
array_pronounce = PronounceablePasswordWithTupleArrays.new './data/probability.csv'

pass_length = 10
starting_letter = ('a'..'z').to_a.sample

array_random_times = []
hash_random_times = []
TIME_FACTORS.each do |time_factor|
  hash_random_times << Benchmark.realtime do
    time_factor.times do
      common_pronouncable_password = [starting_letter]
      while common_pronouncable_password.length < pass_length do
        common_pronouncable_password << hash_pronounce.common_next_letter(common_pronouncable_password.last)
      end
    end
  end

  array_random_times << Benchmark.realtime do
    time_factor.times do
      common_pronouncable_password = [starting_letter]
      while common_pronouncable_password.length < pass_length do
        common_pronouncable_password << array_pronounce.common_next_letter(common_pronouncable_password.last)
      end
    end
  end
end

array_instance_times = []
hash_instance_times = []
TIME_FACTORS.each do |time_factor|
  hash_instance_times << Benchmark.realtime do
    time_factor.times do
      hash_pronounce.build_password_from(starting_letter, pass_length)
    end
  end

  array_instance_times << Benchmark.realtime do
    time_factor.times do
      array_pronounce.build_password_from(starting_letter, pass_length)
    end
  end
end

array_recursion_times = []
hash_recursion_times = []
  TIME_FACTORS.each do |time_factor|
    hash_recursion_times << Benchmark.realtime do
      time_factor.times do
        hash_pronounce.recursive_build_password_from(starting_letter, pass_length)
      end
    end

    array_recursion_times << Benchmark.realtime do
      time_factor.times do
        array_pronounce.recursive_build_password_from(starting_letter, pass_length)
      end
    end
  end

print "PronounceablePasswordWithAGiantHash\n"
print "Times in ms for:\t100\t1000\t10_000\t100_000\t1_000_000 password constructions.\n"
print "Instance method:\t #{hash_instance_times.map { |t| (t * 1000).round(2) }.join("\t")}\n"
print "While loop:\t\t #{hash_random_times.map { |t| (t * 1000).round(2) }.join("\t")}\n"
print "Recursive generation:\t #{hash_recursion_times.map { |t| (t * 1000).round(2) }.join("\t")}\n"

print "\n\n"
print "PronounceablePasswordWithTupleArrays\n"
print "Times in ms for:\t100\t1000\t10_000\t100_000\t1_000_000 password constructions.\n"
print "Instance method:\t #{array_instance_times.map { |t| (t * 1000).round(2) }.join("\t")}\n"
print "While loop:\t\t #{array_random_times.map { |t| (t * 1000).round(2) }.join("\t")}\n"
print "Recursive generation:\t #{array_recursion_times.map { |t| (t * 1000).round(2) }.join("\t")}\n"
