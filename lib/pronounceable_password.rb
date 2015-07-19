require 'csv'
require "pry"

class PronounceablePassword

  def initialize(probability_corpus)
    # probability corpus is the file location of the CSV with the
    # pre-calculated letter probability pairs
    @probability_corpus = probability_corpus
  end

  def read_probabilities
    @probabilities = CSV.read(@probability_corpus, {headers: true})

    @dictionary = {}

    @probabilities.each do |row|
      @dictionary[row[0]] = row[1].to_i
    end
    @dictionary.sort_by { |key, value| value }.reverse!
    print @dictionary

  end

  def possible_next_letters(letter)
    # Should return an array of possible next letters sorted
    # by likelyhood in a descending order
    # @combos.sort_by(values desc)
    # @sorted.select { |hash| hash.keys.  }
    # @dictionary = {"aa" : 1, "ba": 2}
    sorted = @dictionary.select do |k, v|
      k.chars.first
    end

    @sorted


  end

  def most_common_next_letter(letter)
    # The most probable next letter

    # @combos.sort_by(values desc).first
  end

  def common_next_letter(letter, sample_limit = 2)
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring
    # @combos.pluck.limit(1) - that are still near the front?????
  end
end
