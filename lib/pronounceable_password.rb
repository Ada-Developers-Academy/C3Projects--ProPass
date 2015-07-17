require 'csv'
require 'pry'

class PronounceablePassword
  attr_writer :probs


  def initialize(probability_corpus)
    # probability corpus is the file location of the CSV with the
    # pre-calculated letter probability pairs
    @probability_corpus = probability_corpus
    @probs = "no_probs"
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

    matches = @probs.select {|key, value| key.include?(letter)}
    sorted = matches.sort_by {|sound, probbles| probbles }.reverse
    return sorted

    # Should return an array of possible next letters sorted
    # by likelihood in a descending order
  end

  def most_common_next_letter(letter)

    sorted = possible_next_letters(letter)
    next_letter = sorted[0][0][1]
    return
    # The most probable next letter
  end

  def common_next_letter(letter, sample_limit = 2)
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring
  end
end
