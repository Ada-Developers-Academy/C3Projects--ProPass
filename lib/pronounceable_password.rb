require 'csv'

class PronounceablePassword

  def initialize(probability_corpus)
    # probability corpus is the file location of the CSV with the 
    # pre-calculated letter probability pairs
    @probability_corpus = probability_corpus
  end

  def read_probabilities
    # Should consume the provided CSV file into a structure that
    # can be used to identify the most probably next letter
    probability = {}

    probabilities = CSV.foreach(@probability_corpus,{:headers => true}) do |row|

      probability[row[0]] = row[1].to_i
    end  

    return probability 

  end 
  

  def possible_next_letters(letter)
    # Should return an array of possible next letters sorted
    # by likelyhood in a descending order
    
    all_answers = self.read_probabilities
    hash_next_letters = all_answers.select{|letter_pair, count| letter_pair.chars.first == letter}
    array_next_letters = []
    array_next_letters = hash_next_letters.map{|letter_pair,count| {letter_pair => count} }
    # another_hash_next_letters = {}
    # another_hash_next_letters = hash_next_letters.split(",")
    # array_next_letters = []
    # array_next_letters = hash_next_letters.to_a

  end

  def most_common_next_letter(letter)
    # The most probable next letter
   common_letter_hash = self.read_probabilities
   next_letter_likely_hash = common_letter_hash.select{|letter_pair,count| letter_pair.chars.first ==letter }
   next_letter_likely =next_letter_likely_hash.to_s.split""
   answer = next_letter_likely[3]


  
  end

  def common_next_letter(letter, sample_limit = 2)
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring
    array = self.most_common_next_letter(letter)  
  end
end
