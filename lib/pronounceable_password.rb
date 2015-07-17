require 'csv'

class PronounceablePassword

  def initialize(probability_corpus)
    # probability corpus is the file location of the CSV with the
    # pre-calculated letter probability pairs
    @probability_corpus = probability_corpus
  end

  def read_probabilities
    # Should consume the provided CSV file into a structure that
    # can be used to identify the most probably next letter.

    rows = []

    csv_object = CSV.read(@probability_corpus)
    csv_object.shift # to move past the header of the CSV file
    csv_object.each do |row|
      the_row = { row[0] => row[1] }
      rows << the_row
    end

    # "rows" now is an array with hashes
    # ex. [{"'h"=>"2"}, {"ho"=>"2307"}, {"oo"=>"1310"}, {"od"=>"1219"}]
    return rows
  end

  def possible_next_letters(letter)
    # Should return an array of possible next letters sorted
    # by likelyhood in a descending order.
  end

  def most_common_next_letter(letter)
    # The most probable next letter
  end

  def common_next_letter(letter, sample_limit = 2)
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring
  end
end
