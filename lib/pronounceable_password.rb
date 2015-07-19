require 'csv'

class PronounceablePassword

  def initialize(probability_corpus)
    # Probability corpus is the file location of the CSV with the
    # pre-calculated letter probability pairs.

    @probability_corpus = probability_corpus
  end

  def read_probabilities
    # Should consume the provided CSV file into a structure that
    # can be used to identify the most probably next letter.

    hashing_it_up = {}
    csv_object = CSV.read(@probability_corpus)
    csv_object.shift # to move past the header of the CSV file
    csv_object.each do |row|
      hashing_it_up[row[0]] = row[1].to_i
    end

    return hashing_it_up
    # returns ex. {"aa"=>4, "ab"=>100, "az"=>2, "ba"=>4}
  end

  def possible_next_letters(letter)
    # Should return an array of possible next letters sorted
    # by likelyhood in a descending order.

    all_letter_combos = read_probabilities # {"aa"=>4, "ab"=>100, "az"=>2, "ba"=>4}
    select_letter_combos = all_letter_combos.select { |key| key[0] == letter }
    sorted_select_letter_combos =
      select_letter_combos.sort_by { |key, value| value }
        # returns ex. [["az", 2], ["aa", 4], ["ab", 100]]
    sorted_select_letter_combos.reverse!
      # returns ex. [["ab", 100], ["aa", 4], ["az", 2]]

    return reformat_array_of_arrays_to_hash(sorted_select_letter_combos)
    # returns {"ab"=>100, "aa"=>4, "az"=>2}
  end

  def most_common_next_letter(letter)
    # The most probable next letter.

    return possible_next_letters(letter).keys.first[1]
      # lists keys in hash, takes the second character of the first key
    # returns ex. 'b'
  end

  def common_next_letter(letter, sample_limit = 2)
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring.

    count = 0
    possible_letters = []
    possible_next_letters(letter).each_key do |key|
      break possible_letters if count >= sample_limit
      possible_letters << key[1]
      count += 1
    end
    # when break, returns ex. ['b', 'a']

    return possible_letters.sample # randomly selects an element!
    # return 'a'
  end

  private

  def reformat_array_of_arrays_to_hash(array)
    hashing_it_up = {}
    array.each do |pair|
      hashing_it_up[pair[0]] = pair[1]
    end
    return hashing_it_up
    # returns ex. {"az"=>2, "aa"=>4, "ab"=>100}
  end

end
