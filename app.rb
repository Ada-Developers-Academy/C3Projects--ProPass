require_relative './lib/pronounceable_password'
require 'benchmark'
require 'awesome_print'

TIME_FACTORS    = [100, 1000, 5_000, 10_000, 50_000, 100_000, 500_000, 1_000_000]
PASS_LENGTH     = 10
STARTING_LETTER = ('a'..'z').to_a.sample

def benchmark(klass, time_factors = TIME_FACTORS)
  times = {
    while_times:    [],
    instance_times: [],
    recurse_times:  []
  }

  time_factors.each do |time_factor|
    times[:while_times] << Benchmark.realtime do
      time_factor.times do
        password = [STARTING_LETTER]
        while password.length < PASS_LENGTH do
          password << klass.send(:common_next_letter, password.last)
        end
      end
    end

    times[:instance_times] << Benchmark.realtime do
      time_factor.times do
        klass.send(:build_password_from, STARTING_LETTER, PASS_LENGTH)
      end
    end

    times[:recurse_times] << Benchmark.realtime do
      time_factor.times do
        klass.send(:recursive_build_password_from, STARTING_LETTER, PASS_LENGTH)
      end
    end
  end

  return times
end

hash_pronounce =  PronounceablePasswordWithAGiantHash.new './data/probability.csv'
array_pronounce = PronounceablePasswordWithTupleArrays.new './data/probability.csv'

hash_times = benchmark(hash_pronounce)
print "PronounceablePasswordWithAGiantHash\n"
print "Times in ms for:\t100\t1000\t5_000\t10_000\t50_000\t100_000\t500_000\t1_000_000 password constructions.\n"
print "Instance method:\t #{hash_times[:instance_times].map { |t| (t * 1000).round(2) }.join("\t")}\n"
print "While loop:\t\t #{hash_times[:while_times].map { |t| (t * 1000).round(2) }.join("\t")}\n"
print "Recursive generation:\t #{hash_times[:recurse_times].map { |t| (t * 1000).round(2) }.join("\t")}\n"


array_times = benchmark(array_pronounce, TIME_FACTORS.first(4))
print "PronounceablePasswordWithTupleArrays\n"
print "Times in ms for:\t\t100\t\t1000\t\t5_000\t\t10_000 password constructions.\n"
print "Instance method:\t\t #{array_times[:instance_times].map { |t| (t * 1000).round(2) }.join("\t\t")}\n"
print "While loop:\t #{array_times[:while_times].map { |t| (t * 1000).round(2) }.join("\t\t")}\n"
print "Recursive generation:\t\t #{array_times[:recurse_times].map { |t| (t * 1000).round(2) }.join("\t\t")}\n"
