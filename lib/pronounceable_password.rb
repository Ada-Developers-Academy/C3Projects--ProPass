require 'csv'

class PronounceablePassword
  attr_reader :probability_corpus

  def initialize(probability_corpus)
    @probability_corpus = probability_corpus
  end

  # reads CSV letter pair / score data into a single hash corpus
  def read_probabilities
    corpus = {}
    CSV.foreach(self.probability_corpus, encoding: "UTF-8", headers: true ) do |row|
      corpus[row[0]] = row[1].to_i
    end
    corpus
  end

  # returns map of letters to letter pair / score tuples starting with the input letter
  def map_next_letters
    corpus = read_probabilities
    corpus.group_by do |k, v|
      k.chars.first
    end
  end

  # returns sorted (DESC) array of letter pair / score tuples starting with the input letter
  def sorted_letter_pair_score_tuples(letter)
    map_next_letters[letter].sort do |array1, array2| 
      array2.last <=> array1.last
    end
  end

  # returns Array of (just) letters that can follow the input letter
  def possible_next_letters(letter)
    sorted_letter_pair_score_tuples(letter).collect do |pair_score_tuple|
      pair_score_tuple.first.chars.last
    end
  end

  # returns single most common next letter for the input letter
  def most_common_next_letter(letter)
    possible_next_letters(letter).first
  end

  # returns one letter from the set of sample_limit most common following letters
  def common_next_letter(letter, sample_limit = 2)
    restricted_letter_set = possible_next_letters(letter)[0...sample_limit]
    restricted_letter_set.sample
  end
end
