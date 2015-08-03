require 'csv'

class PronounceablePassword
  def initialize(csv_location)
    @csv_location = csv_location
  end

  def prep_database
    read_probabilities
    sort_database
    remove_counts

    @database
  end

  def read_probabilities
    @database = Hash.new(false)
    CSV.foreach(@csv_location, headers: true, header_converters: :symbol) do |row|
      letter_pair = row[:letter_pair].chars
      if @database[letter_pair.first]
        @database[letter_pair.first] << { letter_pair.last => row[:count].to_i }
      else
        @database[letter_pair.first] = [ { letter_pair.last => row[:count].to_i } ]
      end
    end

    @database
  end

  def sort_database
    @database.each do |k, v|
      v.sort_by! { |hash| hash.values }.reverse!
    end

    @database
  end

  def remove_counts
    @database.each do |k, v|
      @database[k] = v.flat_map{ |hash| hash.keys }
    end

    @database
  end

  def possible_next_letters(letter)
    @database[letter]
  end

  def most_common_next_letter(letter)
    possible_next_letters(letter).first
  end

  def common_next_letter(letter, sample_limit = 2)
    possible_next_letters(letter)[0, sample_limit].sample
  end
end
