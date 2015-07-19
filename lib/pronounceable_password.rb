require 'csv'

class PronounceablePassword

  def initialize(probability_corpus)
    # probability corpus is the file location of the CSV with the
    # pre-calculated letter probability pairs
    @probability_corpus = probability_corpus
  end

  def read_probabilities
    # Should consume the provided CSV file into a structure that
    # can be used to identify the most probably next letter
    @probs = {}
    CSV.foreach(@probability_corpus, headers: true) do |row|
      @probs[row[0]] = row[1].to_i
    end
    return @probs
  end

  def reformat(array)
    array.map do |key, value|
      { key => value }
    end
  end

  def possible_next_letters(letter)
    # Should return an array of possible next letters sorted
    # by likelyhood in a descending order
    letter_matches = @probs.select {|key, value| key[0] == letter }
    sorted_matches = letter_matches.sort_by {|key, value| value}.reverse
    formatted_matches = reformat(sorted_matches)
    return formatted_matches
  end

  def most_common_next_letter(letter)
    # The most probable next letter
    formatted_matches = possible_next_letters(letter)
    most_common_letters = formatted_matches.first.keys
    next_letter = most_common_letters[0][1]
    return next_letter
  end

  def common_next_letter(letter, sample_limit = 2)
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring
    random_letter = possible_next_letters(letter)[0...sample_limit]
    next_letter = random_letter.sample.keys[0][1]
    return next_letter
  end
end
