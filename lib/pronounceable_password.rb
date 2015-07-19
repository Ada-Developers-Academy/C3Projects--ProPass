require 'csv'

class PronounceablePassword

  def initialize(probability_corpus)
    # probability corpus is the file location of the CSV with the
    # pre-calculated letter probability pairs
    @probability_corpus = probability_corpus
  end

  def read_probabilities
    # Should consume the provided CSV file into a structure that
    # can be used to identify the most probable next letter
    @letter_probabilities = Array.new
    CSV.foreach(@probability_corpus, :headers => true) do |row|
      letter_combo = row["letter pair"]
      probability = row["count"].to_i
      hash = Hash.new
      hash[letter_combo] = probability
      @letter_probabilities.push(hash)
    end

    return @letter_probabilities
  end

  def possible_next_letters(letter)
    # Should return an array of possible next letters sorted
    # by likelyhood in a descending order
    next_letters = @letter_probabilities.find_all do |letter_hash|
      letter_hash.keys[0][0] == letter
    end

    return next_letters
  end

  def most_common_next_letter(letter)
    # The most probable next letter

    # possible_letters is an array of individual hashes
    possible_letters = possible_next_letters(letter)

    # this will return the hash with the most probable next letter
    most_probable_hash = possible_letters.max_by do |hash|
      # the first is here to get the value out of the array (will always
      # only be one value in the array)
      hash.values.first
    end

    # this will get the next letter out of the hash
    next_letter = most_probable_hash.keys.first[1]
    return next_letter
  end

  def common_next_letter(letter, sample_limit = 2)
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring
  end
end
