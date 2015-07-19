require 'csv'
require 'pry'

class PronounceablePassword

  def initialize(probability_corpus)
    # probability corpus is the file location of the CSV with the
    # pre-calculated letter probability pairs
    @probability_corpus = probability_corpus
  end

  def read_probabilities
    # Should consume the provided CSV file into a structure that
    # can be used to identify the most probably next letter
    hash = {}
    CSV.foreach(@probability_corpus, headers: true) do |row|
      hash[row[0]] = row[1].to_i
    end
    @hash = hash
  end

  def possible_next_letters(letter)
    # Should return an array of possible next letters sorted
    # by likelyhood in a descending order

    filtered_hash = @hash.select {|k,v| letter == k[0]}
    # Create a new array, then fill it with one-element hashes
    array = []
    filtered_hash.each do |k,v|
      array.push({k => v})
    end
    # Sort in decreasing order by the value in each one-element hash
    array.sort_by!{|answer_pair| answer_pair.values[0]}.reverse!
    return array
  end

  def most_common_next_letter(letter)
    # The most probable next letter
    sorted_array = self.possible_next_letters(letter)
    return sorted_array[0].keys[0][1]
  end

  def common_next_letter(letter, sample_limit=2)
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring
    choice = self.possible_next_letters(letter).first(sample_limit).sample
    letter = choice.keys[0][1]
    return letter
  end
end
