require 'csv'

class PronounceablePassword

  def initialize(csv_location)
    @csv_location = csv_location
  end

  def read_probabilities
    @database = []
    CSV.foreach(@csv_location, headers: true, header_converters: :symbol) do |row|
      @database << { row[:letter_pair] => row[:count].to_i }
    end

    @database.sort_by! { |hash| hash.values }.reverse!
  end

  def possible_next_letters(letter)
    @database.select{ |hash| hash.keys.first.chars.first == letter }.map{ |hash| hash.keys.first.chars.last }
  end

  def most_common_next_letter(letter)
    possible_next_letters(letter).first
  end

  def common_next_letter(letter, sample_limit = 2)
    possible_next_letters(letter)[0, sample_limit].sample
  end
end
