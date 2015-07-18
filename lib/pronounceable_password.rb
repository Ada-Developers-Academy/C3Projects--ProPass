require 'csv'

class PronounceablePassword

  def initialize(probability_corpus)
    # probability corpus is the file location of the CSV with the
    # pre-calculated letter probability pairs
    @probability_corpus = probability_corpus
    @probabilities = read_probabilities
  end

  def read_probabilities
    # Should consume the provided CSV file into a structure that
    # can be used to identify the most probably next letter
    # TO CREATE ARRAY OF HASHES INSTEAD:
    # probabilities = []
    #
    # CSV.foreach(@probability_corpus, headers: true) do |row|
    #   probabilities << { row[0] => row[1].to_i}
    # end
    # probabilities

    probabilities = {}

    CSV.foreach(@probability_corpus, headers: true) do |row|
      probabilities[row[0]] = row[1].to_i
    end
    probabilities
  end

  def array_of_hashes(hash)
    array_of_hashes = []
    hash.each do |item|
      item_hash = {item[0] => item[1]}
      array_of_hashes << item_hash
    end
    array_of_hashes
  end

  def possible_next_letters(letter)
    # => array of those with first letter, sorted desc
    prob = @probabilities.select { |p| p.chars.first == letter }
    prob = prob.sort_by { |key, value| value }.reverse.to_h

    array_of_hashes(prob)
  end

  def most_common_next_letter(letter)
    pair = possible_next_letters(letter)[0].keys
    letter = pair.join.chars.last
  end

  def common_next_letter(letter, sample_limit = 2)
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring
    pairs = possible_next_letters(letter)[0...sample_limit]
    pair = pairs.sample(1)[0].keys.join
    char = pair.chars.last
  end
end
