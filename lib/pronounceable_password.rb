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

    #Hash
    letters = {}
    CSV.foreach(@probability_corpus, headers: true) do |line|
      letters.merge!({line[0] => line[1].to_i})

    end

    #Array of tupils
    # letters = []
    # CSV.foreach(@probability_corpus, headers: true) do |line|

    #   letters.push({line[0] => line[1].to_i})


    # end
    letters
  end

  def possible_next_letters(letter)
    # Should return an array of possible next letters sorted
    # by likelyhood in a descending order

    #Hash
    hash = read_probabilities.select do |pair| 
      pair[0] == letter
    end

    hash.sort_by {|pair| pair[1]}.reverse

    #Array of tupils
    # hash = read_probabilities.select do |pair| 
    #   pair.keys[0][0] == letter

    # end

    # hash.sort_by {|pair| pair.values}.reverse
  end


  def most_common_next_letter(letter)
    # The most probable next letter

    #Hash
    possible_next_letters(letter).first[0][1]

    #Array of tupils
    # possible_next_letters(letter).first.first[0][1]
  end

  def common_next_letter(letter, sample_limit = 2)
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring


    #Hash
    possible_next_letters(letter).to_h.keys.sample(sample_limit)

    #Array of tupils
    # pairs = possible_next_letters(letter).sample(sample_limit)

    # pairs.first.keys[0][1]
  end


end

