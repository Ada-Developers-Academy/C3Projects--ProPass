require 'csv'

class PronounceablePassword

  def initialize(probability_corpus)
    # probability corpus is the file location of the CSV with the 
    # pre-calculated letter probability pairs
    @probability_corpus = probability_corpus
    @probs = {}
  end

  def read_probabilities
    # Should consume the provided CSV file into a structure that
    # can be used to identify the most probably next letter
    CSV.foreach(@probability_corpus, headers: true) do |row|
     @probs[row[0]] = row[1].to_i
    end
    return @probs
  end

  def tupelize(array)
    array.map do |pair|
      { pair[0] => pair[1] }
    end
  end

  def possible_next_letters(letter)
    # Should return an array of possible next letters sorted
    # by likelihood in a descending order
    matching_keys = @probs.select { |k,v| k[0] == letter }
    sorted = matching_keys.sort_by { |k,v| v }.reverse
    tupelize(sorted)
  end

  def most_common_next_letter(letter)
    # The most probable next letter
    da_best = possible_next_letters(letter).first
    next_letter = da_best.keys.pop[1]
  end

  def common_next_letter(letter, sample_limit = 2)
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring
    sample_letter = possible_next_letters(letter)[0...sample_limit]
    next_letter = sample_letter.sample.keys.pop[1]
  end
end
