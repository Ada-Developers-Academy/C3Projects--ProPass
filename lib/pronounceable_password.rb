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
    @probabilities = { }

    CSV.foreach(@probability_corpus, headers: true) do |row|
      @probabilities["#{row[0]}"] = row[1].to_i
    end

    return @probabilities
  end

  def possible_next_letters(letter)
    # Should return an array of possible next letters sorted
    # by likelyhood in a descending order
    possible_next_letters = [ ]

    all_matches = @probabilities.select { |key| key[0].include?(letter) }

    sorted_matches = all_matches.sort_by { |key, value| value }.reverse

    #sorted_matches is now [['ab', 3], ['ac' 1]]
    # need to turn this back into hashes
    final_matches = [ ]

    sorted_matches.each do |pair|
      hash = { }
      hash["#{pair.first}"] = pair.last
      final_matches.push(hash)
    end

    return final_matches
  end

  def most_common_next_letter(letter)
    # The most probable next letter

  end

  def common_next_letter(letter, sample_limit = 2)
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring
  end
end
