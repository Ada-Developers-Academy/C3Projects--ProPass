require_relative './spec_helper'
require_relative './custom_expectations'
require_relative '../lib/pronounceable_password'

describe 'Pronounceable Passwords' do

  before :each do
    @pronounce = PronounceablePassword.new './spec/fixtures/tiny_corpus.csv'
    @pronounce.read_probabilities
  end

  it 'will load the probability corpus csv' do
    probabilities = @pronounce.read_probabilities
    expect(probabilities['aa']).to equal 1
    expect(probabilities['kb']).to equal nil
    expect(probabilities['za']).to equal 26
  end

# changed this test to match my output of arrays of arrays, and not an array of hashes
  it 'will pick the next most common letters' do
    expect(@pronounce.possible_next_letters('z')).to eql [["za", 26], ["zb", 10]]
  end

  it 'will pick the next best letter' do
    expect(@pronounce.most_common_next_letter('z')).to eql 'a'
  end

  it 'will pick the next best letter from a subset of the most common options' do
    expect(@pronounce.common_next_letter('z')).to be_one_of(['a','b'])
  end
end
