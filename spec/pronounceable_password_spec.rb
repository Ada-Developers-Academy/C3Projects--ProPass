require_relative './spec_helper'
require_relative './custom_expectations'
require_relative '../lib/pronounceable_password'

describe 'Pronounceable Passwords' do
  before :each do
    @pronounce = PronounceablePassword.new './spec/fixtures/tiny_corpus.csv'
  end

  it 'will load the probability corpus csv' do
    expect(@pronounce.letter_hash.length).to eq 26
    expect(@pronounce.letter_hash['a']).to eq ["a"]
    expect(@pronounce.letter_hash['k']).to eq ["a"]
    expect(@pronounce.letter_hash['z']).to eq ["a", "b"]
    expect(@pronounce.letter_hash['-']).to eq nil
  end

  it 'will pick the next most common letters' do
    expect(@pronounce.possible_next_letters('z')).to eql ["a", "b"]
  end

  it 'will pick the next best letter' do
    expect(@pronounce.most_common_next_letter('z')).to eql 'a'
  end

  it 'will pick the next best letter from a subset of the most common options' do
    expect(@pronounce.common_next_letter('z')).to be_one_of(['a','b'])
  end

  context "PronounceablePassword#build_password_from" do
    it "builds a password using the less deterministic approach" do
      expect(@pronounce.build_password_from('z', 3)).to be_one_of(['zba','zaa'])
    end

    it "builds a 10 character password by default" do
      expect(@pronounce.build_password_from('z').length).to eq 10
    end

    it "accepts an optional second parameter that defines the password length" do
      expect(@pronounce.build_password_from('z', 4).length).to eq 4
    end
  end
end
