require_relative './spec_helper'
require_relative './custom_expectations'
require_relative '../lib/pronounceable_password'

describe 'Pronounceable Passwords' do

  before :each do
    @pronounce = PronounceablePassword.new './spec/fixtures/tiny_corpus.csv'
    @pronounce.read_probabilities
  end

  context 'loading the probability corpus csv' do
    let(:probabilities) { @pronounce.read_probabilities }
    it 'will return the correct values' do
      pairs = { 'aa' => 1, 'za' => 26, 'ha' => 8 }

      pairs.each do |key, value|
        pair = probabilities.find { |item| item.keys.first == key }
        expect(pair[key]).to eq value
      end
    end

    it 'will return nil if letter pair is not in the csv' do
      nil_pair = {'kb' => nil}
      pair = probabilities.find { |item| item.keys.first == nil_pair['kb'] }
      expect(pair).to eq nil
    end
  end

  it 'will pick the next most common letters' do
    expect(@pronounce.possible_next_letters('z')).to eql [{"za"=>26}, {"zb"=>10}]
  end

  it 'will pick the next best letter' do
    expect(@pronounce.most_common_next_letter('z')).to eql 'a'
  end

  it 'will pick the next best letter from a subset of the most common options' do
    expect(@pronounce.common_next_letter('z')).to be_one_of(['a','b'])
  end
end
