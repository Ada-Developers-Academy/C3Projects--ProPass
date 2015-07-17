require 'csv'

class PronounceablePassword
  attr_reader :probability_corpus

  def initialize(probability_corpus)
    # probability corpus is the file location of the CSV with the 
    # pre-calculated letter probability pairs
    @probability_corpus = probability_corpus
  end

  # 
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

  # returns Hash (of hashes)
  # key is letter (string)
  # value is hash
  # => key is letter pair
  # => value is score
  def map_next_letters
    corpus = read_probabilities
    corpus.group_by do |hash|
      hash.keys.first.chars.first
    end
  end

  # returns Array (of hashes)
  # hashes are sorted descending by score
  # in each hash, 
  # => key is pair string
  # => value is score
  def pair_score_hash(letter)
    map_next_letters[letter].sort do |hash1, hash2| 
      hash2.values.first.to_i <=> hash1.values.first.to_i
    end
  end

  # returns Array (of strings)
  # elements are letters that can follow the input letter
  def possible_next_letters(letter)
    # Should return an array of hash objects of which the second letter of the key is
    # possible next letters sorted
    # by likelyhood in a descending order
    # eg. put in a, get [b, e, d, t]
    # pair_score_hash = map_next_letters[letter]
    pair_score_hash(letter).collect do |pair_score_tuple|
      pair_score_tuple.keys.first.chars.last
    end
  end

  # want to return single most common next letter
  def most_common_next_letter(letter)
    # The most probable next letter
    possible_next_letters(letter).first
    
    # max_tuple = pair_score_hash(letter).max_by do |pair_score_tuple|
    #   pair_score_tuple.values.first.to_i
    # end
    # max_tuple.keys.first.chars.last
  end

  def common_next_letter(letter, sample_limit = 2)
    restricted_letter_set = possible_next_letters(letter)[0...sample_limit]
    restricted_letter_set.sample
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring

  end
end
