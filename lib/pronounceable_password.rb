require 'csv'
require "pry"

class PronounceablePassword
  attr_accessor :dictionary

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

    @dictionary
  end

  def possible_next_letters(letter)
    # Should return an array of possible next letters sorted
    # by likelyhood in a descending order
    @sorted = @dictionary.sort_by { |key, value| value }.reverse!

    @possible = []
    @sorted.each do |pair| # ["za", 26]
      if pair[0].chars.first == letter
        @possible.push(pair)
      end
    end

    @possible
  end

  def most_common_next_letter(letter)
    # The most probable next letter
    letter = possible_next_letters(letter).first

    letter[0].chars.last
  end

  def common_next_letter(letter, sample_limit = 2)
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring
    letter = possible_next_letters(letter)[0...sample_limit].sample
    letter[0].chars.last
  end
end
