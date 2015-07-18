require 'csv'
require 'pry'

class PronounceablePassword

  def initialize(probability_corpus)
    @probability_corpus = probability_corpus
    @probabilities = read_probabilities
  end

  def read_probabilities
    # CREATE ARRAY OF HASHES:
    probabilities = []

    CSV.foreach(@probability_corpus, headers: true) do |row|
      probabilities << { row[0] => row[1].to_i}
    end
    probabilities
  end

  # WIP
  def possible_next_letters(letter)
    prob = @probabilities.select { |hash| hash.keys.first == letter }
    prob = prob.sort_by { |key, value| value }.reverse.to_h


    # => array of those with first letter, sorted desc
    # prob = @probabilities.select { |p| p.chars.first == letter }
    # prob = prob.sort_by { |key, value| value }.reverse.to_h
    #
    # array_of_hashes(prob)
  end
end
