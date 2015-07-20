require 'csv'

class PronounceablePassword
  def initialize(csv_location)
    @csv_location = csv_location
  end

  end

  def read_probabilities
    @database = Hash.new(false)
    CSV.foreach(@csv_location, headers: true, header_converters: :symbol) do |row|
      if @database[row[:letter_pair].chars.first]
        # puts "#{ row[:letter_pair].chars.first } exists as a key."
        @database[row[:letter_pair].chars.first] << { row[:letter_pair].chars.last => row[:count].to_i }
      else
        # puts "#{ row[:letter_pair].chars.first } is NOT a key."
        @database[row[:letter_pair].chars.first] = [ { row[:letter_pair].chars.last => row[:count].to_i } ]
      end
      # print @database
    end

    sort_database
    remove_counts
  end

  def sort_database
    @database.each do |k, v|
      v.sort_by! { |hash| hash.values }.reverse!
    end
    # print @database
  end

  def remove_counts
    @database.each do |k, v|
      @database[k] = v.flat_map{ |hash| hash.keys }
    end
    # print @database
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
