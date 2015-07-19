require 'csv'
require 'pry'

class PronounceablePassword

  def initialize(probability_csv) #renamed for clarity
    # probability corpus is the file location of the CSV with the
    # pre-calculated letter probability pairs
    @probability_csv = probability_csv
  end

  def read_probabilities
    # Should consume the provided CSV file into a structure that
    # can be used to identify the most probably next letter
    @hash = {}

    CSV.foreach(@probability_csv, headers: true) do |row|
      @hash[row[0]] = row[1].to_i
    end
    return @hash
  end


  def possible_next_letters(letter)
    # Should return an array of possible next letters sorted
    # by likelyhood in a descending order

    #returns one hash with key values of all matching letter pairs
    return_hash = @hash.select {|c| c.start_with?(letter) }

    # returns array of arrays of descending order
    sorted = return_hash.sort_by { |c| c[1] }.reverse!

    # converts array of arrays into array of tuples
    sorted_hash = sorted.map { |array| {array[0] => array[1]} }
    return sorted_hash
  end


  def most_common_next_letter(letter)
    # The most probable next letter

    #returns array of top letter pair
    letter_pair = possible_next_letters(letter).first.keys

    #returns letter pair as string
    letter_string = letter_pair.first

    # returns array of seperated letters
    letter_array= letter_string.split(//)

    # returns second letter
    second_letter = letter_array[1]

    return second_letter
  end

  def common_next_letter(letter, sample_limit = 2)
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring

    # return top n tuples
    top_tuples = possible_next_letters(letter)[0..(sample_limit - 1)]

    # returns array of string pairs
    letter_pairs = top_tuples.map { |hash| hash.keys.first }

    # returns array of second letters
    second_letter_array = letter_pairs.map { |pair| pair[-1]}

    return second_letter_array.sample
  end
end







