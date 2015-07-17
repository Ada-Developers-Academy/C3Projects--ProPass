require 'csv'
# require 'pry'

class PronounceablePassword

  def initialize(probability_corpus)
    # probability corpus is the file location of the CSV with the
    # pre-calculated letter probability pairs
    @probability_corpus = probability_corpus
  end

  def read_probabilities
    # Should consume the provided CSV file into a structure that
    # can be used to identify the most probably next letter

    @probabilities = {}

    CSV.foreach(@probability_corpus, headers: true) do |row|
      @probabilities[row[0]] = row[1].to_i
    end

    @probabilities
  end

  def possible_next_letters(letter)
    # Should return an array of possible next letters sorted
    # by likelyhood in a descending order
    pairs = @probabilities.select { |h| h[0,1] == letter }
    pairs_array = []

    # formats the pairs like [{'za' => 26}, {'zb' => 10}]
    # oringally they're {'za' => 26, 'zb' => 10}
    pairs.each do |pair|
      pairs_array << Hash[*pair]
    end

    pairs_array
  end

  def most_common_next_letter(letter)
    # The most probable next letter

    most_common_pair = possible_next_letters(letter).max do |hash1, hash2|
      # checking one at a time doesn't return the max value
      hash1.values.first <=> hash2.values.first
    end

    most_common_pair.keys.first[1,1]
  end

  def common_next_letter(letter, sample_limit = 2)
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring
    pairs = possible_next_letters(letter).sample(sample_limit)
    pairs.map { |hash| hash.keys.first[1,1] }.sample
  end
end
