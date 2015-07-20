require 'csv'

class PronounceablePassword
  attr_reader :letter_hash, :probability_corpus

  def initialize(probability_corpus)
    # probability corpus is the file location of the CSV with the 
    # pre-calculated letter probability pairs
    @probability_corpus = probability_corpus
    @letter_hash = {}

    read_probabilities!
    sort_subsets!
  end

  def build_password_from(letter, password_length = 10)
    password = letter.dup # we don't want to mutate letter
    (password_length - 1).times do |index|
      password << common_next_letter(password[index])
    end

    password
  end

  def recursive_build_password_from(password, password_length = 10)    
    return password if password_length == 1
    
    recursive_build_password_from(password + common_next_letter(password[-1]), password_length - 1)
  end

  def possible_next_letters(letter)
    # Should return an array of possible next letters sorted
    # by likelyhood in a descending order
    letter_hash.fetch(letter)
  end

  def most_common_next_letter(letter)
    # The most probable next letter
    possible_next_letters(letter).first
  end

  def common_next_letter(letter, sample_limit = 2)
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring
    possible_next_letters(letter).first(sample_limit).sample
  end

  private

  def read_probabilities!
    # Should consume the provided CSV file into a structure that
    # can be used to identify the most probably next letter
    # makes a hash of hashes:
    # {
    #   "a" => { "a" => 1, "b" => 23, "c" => 3 },
    #   "b" => { "b" => 2, "c" => 5, "a" => 33 }
    # }
    CSV.open(probability_corpus, 'r', { headers: true }).each do |line|
      first_char, last_pair = line.fetch("letter pair").chars
      letter_hash[first_char] ||= {}
      letter_hash[first_char][last_pair] ||= 0
      letter_hash[first_char][last_pair] += line.fetch("count", 0).to_i
    end
  end

  def sort_subsets!
    letter_hash.each do |letter, subset|
      sorted_subset = subset.sort { |a,b|  b[1] <=> a[1] }
      letter_hash[letter] = sorted_subset.map &:first
    end
  end
end
