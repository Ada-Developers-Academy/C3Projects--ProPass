require 'csv'

class PronounceablePassword
  attr_reader :probabilities

  def initialize(probability_corpus)
    # probability corpus is the file location of the CSV with the
    # pre-calculated letter probability pairs
    @probability_corpus = probability_corpus
  end

  def read_probabilities
    # Should consume the provided CSV file into a structure that
    # can be used to identify the most probably next letter

    hash_form = {}

    # !W remove the header row later.
    # update: I cheated and deleted it from the CSV.
    array_form = CSV.read(@probability_corpus)

    array_form.each { |row|
      hash_form[row.first] = row.last.to_i
    }

    @probabilities = hash_form

    return hash_form
  end

  def possible_next_letters(letter)
    # Should return an array of possible next letters sorted
    # by likelyhood in a descending order

    letter_values = probabilities.select { |key, value| key[0] == letter }
    ascending_array = letter_values.sort_by { |key, value| value }
    descending_array = ascending_array.reverse
    descending_array.map { |array| {array.first => array.last} }
  end

  def most_common_next_letter(letter)
    # The most probable next letter
    best_response = possible_next_letters(letter).first
    best_response.keys.pop[1]
  end

  def common_next_letter(letter, sample_limit = 2)
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring
    responses = possible_next_letters(letter)

    letters = responses.map{ |hash| hash.keys.pop[1] }

    if letters.length <= sample_limit
      return letters.sample
    else
      return letters[(0...sample_limit).to_a.sample]
    end
  end
end
