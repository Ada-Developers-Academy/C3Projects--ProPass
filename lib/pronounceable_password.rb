require 'csv'
require 'pry'

class PronounceablePassword
  attr_reader :probablity_hash

  def initialize(probability_corpus)
    # probability corpus is the file location of the CSV with the
    # pre-calculated letter probability pairs
    # this happens when the app.rb file loads, nothing else needs to happen here
    @probability_corpus = probability_corpus
  end

  def read_probabilities
    # Should consume the provided CSV file into a structure that
    # can be used to identify the most probably next letter

    each_hash = {}

    open_csv = CSV.read(@probability_corpus, :headers => true)

    # makes a hash of key value pairs matching the letter combo with the count
    open_csv.each do |row|
      each_hash[row[0]] = row[1].to_i
    end
    @probability_hash = each_hash

  end


  def possible_next_letters(letter)
    # Should return an array of possible next letters sorted
    # by likelyhood in a descending order
    # matches for the randomized letter passed in
    random_letter_collection = @probability_hash.select { |key, value| key[0].include?(letter) }
    # use reverse to switch from ascending (default sort) to descending likelihood
    sorted_array = random_letter_collection.sort_by { |key, value| value }.reverse
    # changes it to an array of tuples (sp?) arrays
    sorted_array.map { |array| {array.first => array.last} }
  end

  def most_common_next_letter(letter)
    # The most probable next letter
    # Returns the first (most likely) key value pair
    most_probable = possible_next_letters(letter).first
    # takes the key and returns just the second letter index[1]
    most_probable.keys.pop[1]
  end

  def common_next_letter(letter, sample_limit = 2)
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring
    tuple_array = possible_next_letters(letter)
    # just the second letter
    letters_array = tuple_array.map{ |hash| hash.keys.pop[1] }
    # returns the most common based on the sample limit
    pretty_common = letters_array.first(sample_limit)

    # randomly selects one of those
    choose_letter = pretty_common.sample
    return choose_letter
  end
end
