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
      # row = [ letter_pair, count]
      # hash[letter_pair] = count
    end
    return hash
  end

  def possible_next_letters(letter)
    # Should return an array of possible next letters sorted
    # by likelyhood in a descending order


    all_probabilities_hash = self.read_probabilities
    # pulling out ones that start with that letter from all_probabilities hash
    probabilities_array = all_probabilities_hash.select { |letter_pair, count| letter_pair.chars.first == letter }.to_a
    # letter_pair is the key which is a string. call '.chars.first' to see if the first letter of the string == the input letter and it'll select all the corresponding keys.
    # returns an array of arrays (each record is a separate array in this huge array)

    probabilities_array.sort_by! { |subarray| -subarray[1] }
    # negative to get it sorted by descending order
    return probabilities_array

  end

  def most_common_next_letter(letter)
    # The most probable next letter
    sorted_array = self.possible_next_letters(letter)
    sorted_array.first[0][1]
    # Within the sorted array,
  end

  def common_next_letter(letter, sample_limit = 5) # or just sample_limit
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring
    random_choices = self.possible_next_letters(letter)
    random_choices.sample(sample_limit)
  end

end
