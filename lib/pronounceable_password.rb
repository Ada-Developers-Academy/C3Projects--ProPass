require 'csv'

class PronounceablePassword

  attr_accessor :probability

  def initialize(data_set)
    # data_set is the file location of the CSV with the 
    # pre-calculated letter probability pairs
    @data_set = data_set
    @probability = {}

  end

  def read_probabilities
    # Should consume the provided CSV file into a structure that
    # can be used to identify the most probably next letter

    # ATTEMPT 1

        # CSV.open(@data_set, headers: true).each do |prob_pair|
        #   @probability_pairs.push(prob_pair)
        # end

        # return @probability_pairs
        
        # => <CSV::Row "letter pair":"m." "count":"3">

    # ATTEMPT 2

        # hash_data = {}

        # @probability_pairs.each do |letters, probability|
        #   hash_data[letters => probability]
        # end

        # return @probability_pairs
        # => <CSV::Row "letter pair":"m." "count":"3">

    # ATTEMPT 3

        # CSV.read(@data_set, headers:true).collect do |row|
        #   Hash[row.collect { |c,r| [c,r]}]
        # end

        # => [{"letter pair"=>"'h", "count"=>"2"}, {"letter pair"=>"ho", .... ]

    # ATTEMPT 4

        # data = CSV.table(@data_set).to_a
        # @hash_data = Hash[data]
        # return @hash_data

        # => {:letter_pair=>:count, "'h"=>2, "ho"=>2307, "oo"=>1310, ...


    # ATTEMPT 5 -- 

        prob_data = CSV.read(@data_set, headers: true)
        hash_prob_data = {}

        prob_data.each do |pair|
          hash_prob_data[pair[0]] = pair[1].to_i
        end

        @probability = hash_prob_data

        return @probability

       # => {"'h"=>2, "ho"=>2307, "oo"=>1310, "od"=>1219, ...

  end

  def possible_next_letters(letter)
    # Should return an array of possible next letters sorted
    # by likelyhood in a descending order
    read_probabilities
 
    pairs_including_letter = @probability.select {|key, value| key[0].include?(letter)}
    # => {"an"=>6566, "am"=>1952, "a'"=>16, "a-"=>91, ...
    ordered_pairs = pairs_including_letter.sort_by {|key, value| value }.reverse
    # => [["an", 6566], ["at", 5290], ["ar", 5011], ["al", 4371], ["ac", 2952], ...
    pairs_tuple = ordered_pairs.collect {|key, value| {key => value}}
    # => [{"an"=>6566}, {"at"=>5290}, {"ar"=>5011}, {"al"=>4371}, {"ac"=>2952},

    return pairs_tuple
  end

  def most_common_next_letter(letter)
    # The most probable next letter

    most_common_pair = possible_next_letters(letter).first.keys 
    # .first => {"an"=>6566} 
    # .first.keys => ["an"]
    second_letter = most_common_pair[0][1]
    # most_common_pair[0] => "an"
    # most_common_pair[1] => nil
    # most_common_pair[0][0] => "a"
    # most_common_pair[0][1] => "n"

    return second_letter 

  end

  def common_next_letter(letter, sample_limit = 2)
    # Randomly select a common letter within a range defined by
    # the sample limit as the lower bounds of a substring

    common_letters = []

    sample_limit_pairs = possible_next_letters(letter).first(sample_limit)
    # => [{"an"=>6566}, {"at"=>5290}, {"ar"=>5011}, {"al"=>4371}] if... (sample_limi =4)

    sample_limit_pairs.each do |pair|
      key_array = pair.keys
      # => ["an"]
      key_value = key_array.first
      # => "an"
      second_letter = key_value[1]
      # => "n"
      common_letters.push(second_letter)
    end

    random_letter = common_letters.sample

    return random_letter

  end
end
