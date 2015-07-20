require 'csv'
# require 'pry'

class PronounceablePassword

  def initialize(probability_corpus)
    # probability corpus is the file location of the CSV with the
    # pre-calculated letter probability pairs
    @probability_corpus = probability_corpus
  end

  def read_probabilities
    @pairs = {}
    CSV.foreach(@probability_corpus, headers: true) do |row|
      @pairs[row[0]] = row[1].to_i
      end
    format
    # Should consume the provided CSV file into a structure that
    # can be used to identify the most probably next letter
  end

  def format
    @probabilities = []
    @pairs.each do |key, value|
      @mini_hash = {}
      @mini_hash[:key] = value
      @probabilities << @mini_hash
    end
  end

  def possible_next_letters(letter)
    read_probabilities
    @pairs.select {|key, value| key[0] == letter}
    # Should return an array of possible next letters sorted
    # by likelyhood in a descending order
  end

  def most_common_next_letter(letter)
    @array = possible_next_letters(letter).sort_by do |key, value|
      value
    end
    @array.last[0].split(//).last
    # The most probable next letter
  end

  def common_next_letter(letter, sample_limit = 2)
    @array = possible_next_letters(letter).sort_by do |key, value|
      value
    end
    @highest = @array.pop(sample_limit)
    @letter = @highest.sample
    @letter[0].split(//).last
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring
  end
end
