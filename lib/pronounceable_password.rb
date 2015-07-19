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
      the_row = { row[0] => row[1].to_i }
      rows << the_row
    end

    # "rows" now is an array with hashes
    # ex. [{"'h"=>"2"}, {"ho"=>"2307"}, {"oo"=>"1310"}, {"od"=>"1219"}]
    # return rows

    return combine_array_into_single_hash(rows)
    # returns ex. {"aa"=>1, "ba"=>2, "ca"=>3, "da"=>4}
  end

  def possible_next_letters(letter)
    # Should return an array of possible next letters sorted
    # by likelyhood in a descending order.

    rows = read_probabilities
    possibilities_from_letter = rows.select { |row| row.first[0][0] == letter }
    letters_sorted_by_possibility =
      possibilities_from_letter.sort_by { |row| row.first[1] }.reverse
    # returns ex. [{"za"=>26}, {"zb"=>10}]
  end

  def most_common_next_letter(letter)
    # The most probable next letter.

    possible_next_letters(letter).first.keys.first[1]
      # first in array, keys in hash, first (and only) value, and second character
    # returns ex. 'e'
  end

  def common_next_letter(letter, sample_limit = 2)
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring.

    ### ONE POSSIBLE WAY:
    # new_hash = combine_array_into_single_hash(possible_next_letters(letter))
    #   # results in: ex. {"za"=>26, "zb"=>10}
    #
    # count = 0
    # possible_letters = []
    # new_hash.each_value do |value|
    #   break if count >= sample_limit
    #   possible_letters << value
    #   count += 1
    # end

    ### ANOTHER POSSIBLE WAY:
    count = 0
    possibilities = possible_next_letters(letter).reduce([]) do |array, pair|
      break if count >= sample_limit
      pair.each_key do |key|
        array << key[1]
      end
      count += 1
      array
    end

    possibilities.sample # randomly selects an element!

    # returns ex. ['a','b']
  end

  private

  # DIDN'T END UP USING, BUT WAS GOOD REFERENCE FOR #common_next_letter METHOD
  def combine_array_into_single_hash(array)
    # {} is the initial value
    # hash is the hash that will grow (be added to) every iteration
    # pairs is the {"ab" => 2}
    array.reduce({}) do |hash, pair|
      pair.each do |key, value|
        # this will always only run once, since there is only one pair in each mini-hash
        # adds the value to the key for the empty hash (or growing hash)
        hash[key] = value
      end
      hash # returns hash value for the next iteration
    end
  end
  # returns a hash with all the values inside it
  # instead of an array with individual hashes
end
