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
    sort
  end

  def sort
    @sorted = @dictionary.sort_by { |key, value| value }.reverse!
    # sorted is arrays within an array
    # [["za", 26], ["ya", 25]...["zb", 10]]
    print @sorted
    binding.pry
  end

  def possible_next_letters(letter)
    # Should return an array of possible next letters sorted
    # by likelyhood in a descending order


    @sorted.each do |pair| # ["za", 26]
    possibilites = []
      if pair[0].chars.first == letter
        possibilites << pair
      end
    end
    puts "possibilities:"
    print possibilities
    possibilities
  end

  def most_common_next_letter(letter)
    # The most probable next letter
    possible_next_letters(letter).first
  end

  def common_next_letter(letter, sample_limit = 2)
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring
    # @combos.pluck.limit(1) - that are still near the front?????
    possible_next_letters(letter)
  end
end
