require 'csv'
require 'pry'

class PronounceablePassword
  attr_accessor :probs


  def initialize(probability_corpus)
    # probability corpus is the file location of the CSV with the
    # pre-calculated letter probability pairs
    @probability_corpus = probability_corpus
    @probs = {}
  end

  def read_probabilities

    mouth_sounds = CSV.read(@probability_corpus, :headers => true)

    hash_fulla_sounds_and_nums = {}

    mouth_sounds.each do |blurp|
    hash_fulla_sounds_and_nums[blurp[0]] = blurp[1].to_i
    end

    @probs = hash_fulla_sounds_and_nums
    # Should consume the provided CSV file into a structure that
    # can be used to identify the most probably next letter

  end

  def possible_next_letters(letter)

    all_matches = @probs.select {|key, value| key[0].include?(letter)}
    sorted_array = all_matches.sort_by {|sound, probbles| probbles }.reverse
    tuple_version = sorted_array.collect {|sound, probbles| {sound => probbles}}
    return tuple_version

    # Should return an array of possible next letters sorted
    # by likelihood in a descending order
  end

  def most_common_next_letter(letter)

    tuple_version = possible_next_letters(letter)
    most_common_sound = tuple_version.first.keys
    second_letter = most_common_sound[0][1]
    return second_letter
    # The most probable next letter
  end

  def common_next_letter(letter, sample_limit = 2)

    common_letters = []

    tuple_version = possible_next_letters(letter)
      # [{sound => number}, {sound => number},... ]
    most_common_sounds = tuple_version.first(sample_limit)
      # limits that giant array to just two (or whatever limit)
    index = 0
      # just a counter

    most_common_sounds.length.times do
      a_sound = most_common_sounds[index].keys
      # ["oy"]
      a_sound_string = a_sound.first
      # "oy"
      just_the_second_letter = a_sound_string[1]
      # "y"
      common_letters.push(just_the_second_letter)

      index += 1
    end

    # ___ DEBUGGING CHECKS ___
    # puts "most common sounds is #{most_common_sounds}"
    # puts "index is #{index}"
    # puts "common_letters is #{common_letters}"
    rando_letter = common_letters.sample
    return rando_letter

    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring
  end
end
