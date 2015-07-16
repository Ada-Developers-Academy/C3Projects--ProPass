require 'csv'

class PronounceablePassword
  attr_reader :probability_corpus

  def initialize(probability_corpus)
    # probability corpus is the file location of the CSV with the 
    # pre-calculated letter probability pairs
    @probability_corpus = probability_corpus
  end

  def read_probabilities
    # Should consume the provided CSV file into a structure that
    # can be used to identify the most probably next letter
    corpus = []
    CSV.foreach(self.probability_corpus, encoding: "UTF-8", headers: true ) do |row|
      row_hash = {row[0] => row[1]}
      corpus << row_hash
    end
    corpus
  end

  def map_next_letters
    corpus = read_probabilities
    corpus.group_by do |hash|
      hash.keys.first.chars.first
    end
  end

  def possible_next_letters(letter)
    # Should return an array of possible next letters sorted
    # by likelyhood in a descending order
    # eg. put in a, get [b, e, d, t]
    letter_hash = map_next_letters[letter]
    letter_hash.collect do |pair_score_tuple|
      pair_score_tuple.keys.first.chars.last
    end
  end

  def most_common_next_letter(letter)
    # The most probable next letter
  end

  def common_next_letter(letter, sample_limit = 2)
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring 
  end
end
