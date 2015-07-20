require 'csv'

class PronounceablePassword

  def initialize(probability_corpus)
    @probability_corpus = probability_corpus
    @probabilities = read_probabilities
  end

  def read_probabilities
    probs = CSV.read(@probability_corpus, headers: true)
    # Sort by first letter, then by value
    probs = probs.sort_by { |row| [ row[0].chars.first, -row[1].to_i ] }

    # Transform into array of hashes
    array_of_hashes(probs)
  end

  def array_of_hashes(array)
    array_of_hashes = []
    array.each do |item|
      item_hash = { item[0] => item[1].to_i }
      array_of_hashes << item_hash
    end
    array_of_hashes
  end

  def possible_next_letters(letter)
    @probabilities.select { |p| p.keys.first.chars.first == letter }
  end

  def most_common_next_letter(letter)
    pair = possible_next_letters(letter).first
    pair.keys.join.chars.last
  end

  def common_next_letter(letter, sample_limit = 2)
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring
    pairs = possible_next_letters(letter)[0...sample_limit]
    pair = pairs.sample(1)[0].keys.join
    pair.chars.last
  end

end
