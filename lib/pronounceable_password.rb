require 'csv'
require 'pry'

class PronounceablePassword

  def initialize(probability_corpus)
    # probability corpus is the file location of the CSV with the
    # pre-calculated letter probability pairs
    @probability_corpus = probability_corpus # replaces csv file...
  end


  def read_probabilities # should say read_csv...
    # Should consume the provided CSV file into a structure that
    # can be used to identify the most probably next letter

    hash = {}

    CSV.foreach(@probability_corpus, { headers: true}) do |row|
      hash[row[0]] = row[1].to_i
      # each row in the csv file equals an array with a letter_pair and count
      # for each letter_pair & count, put it in a hash, and set the key (index 0) => value (index 1)
    end
    return hash
  end

  def possible_next_letters(letter)
    # Should return an array of possible next letters sorted
    # by likelyhood in a descending order

    all_probabilities_hash = self.read_probabilities
    # one giant hash

    probabilities_array = all_probabilities_hash.select { |letter_pair, count| letter_pair.chars.first == letter }.to_a
    # for each key-value pair in the hash, select the ones that return true if the key's first
    # character equals the letter input, and insert each into separate arrays within one parent array

    probabilities_array.sort_by! { |sub_array| -sub_array[1] }
    # sort all the elements of the probabilities_array by each sub_array's 2nd index, 'count,' in descending order
    return probabilities_array

  end

  def most_common_next_letter(letter)
    # The most probable next letter

    sorted_array = self.possible_next_letters(letter)
    sorted_array.first[0][1]
    # Within the sorted array, find the most common letter_pair, amd return the second letter
  end

  def common_next_letter(letter, sample_limit = 5) # or just sample_limit??
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring
    random_choices = self.possible_next_letters(letter)
    random_choices.sample(sample_limit)
  end

end
