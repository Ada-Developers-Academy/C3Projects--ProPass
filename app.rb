require_relative './lib/pronounceable_password'
require 'benchmark'
require 'awesome_print'

TIME_FACTORS = [100, 1000, 10_000, 100_000, 1_000_000]

pronounce = PronounceablePassword.new './data/probability.csv'

pass_length = 10
starting_letter = ('a'..'z').to_a.sample

random_times = []
TIME_FACTORS.each do |time_factor|
  random_times << Benchmark.realtime do
    time_factor.times do
      common_pronouncable_password = [starting_letter]
      while common_pronouncable_password.length < pass_length do
        common_pronouncable_password << pronounce.common_next_letter(common_pronouncable_password.last)
      end
    end
  end
end

instance_times = []
TIME_FACTORS.each do |time_factor|
  instance_times << Benchmark.realtime do
    time_factor.times do
      pronounce.build_password_from(starting_letter, pass_length)
    end
  end
end

recursion_times = []
  TIME_FACTORS.each do |time_factor|
    recursion_times << Benchmark.realtime do
      time_factor.times do
        pronounce.recursive_build_password_from(starting_letter, pass_length)
      end
    end
  end

print "Times in ms for:\t100\t1000\t10_000\t100_000\t1_000_000 password constructions.\n"
print "Instance method:\t #{instance_times.map { |t| (t * 1000).round(2) }.join("\t")}\n"
print "While loop:\t\t #{random_times.map { |t| (t * 1000).round(2) }.join("\t")}\n"
print "Recursive geneation:\t #{recursion_times.map { |t| (t * 1000).round(2) }.join("\t")}\n"
