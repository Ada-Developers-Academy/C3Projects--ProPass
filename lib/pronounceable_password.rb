require 'csv'
require 'pry'

class PronounceablePassword

  def initialize(probability_corpus)
    # probability corpus is the file location of the CSV with the
    # pre-calculated letter probability pairs
    @probability_corpus = probability_corpus
  end
    # data = Array.new

  def read_probabilities
    # Should consume the provided CSV file into a structure that
    # can be used to identify the most probably next letter
    hash = {}
    CSV.foreach(@probability_corpus, { headers: true, header_converters: :symbol}) do |row|
      hash[row[0]] = row[1].to_i
    end
    return hash
  end

  def possible_next_letters(letter)
    # Should return an array of possible next letters sorted
    # by likelyhood in a descending order
  end

  def most_common_next_letter(letter)
    # The most probable next letter
  end

  def common_next_letter(letter, sample_limit = 2)
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring
  end
end
