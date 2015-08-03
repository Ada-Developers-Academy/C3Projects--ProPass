require_relative './spec_helper'
require_relative './custom_expectations'
require_relative '../lib/pronounceable_password'

describe 'Pronounceable Passwords' do
  let(:propass) { PronounceablePassword.new './spec/fixtures/tiny_corpus.csv' }

  describe "database prep" do
    describe "#read_probabilities" do
      let(:database) { propass.read_probabilities }

      it 'loads the probability corpus csv' do
        expect(database['a']).to eq [{"a"=>1}]
        expect(database['k']).to eq [{"a"=>11}]
      end

      it "does not sort the database" do
        expect(database['z']).to eq [{"b"=>10}, {"a"=>26}]
      end
    end

    describe "#sort_database" do
      before :each do
        propass.read_probabilities
        @database = propass.sort_database
      end

      it "sorts each letter's array by prevalence" do
        expect(@database['z']).to eq [{"a"=>26}, {"b"=>10}]
      end
    end

    describe "#remove_counts" do
      before :each do
        propass.read_probabilities
        @database = propass.remove_counts
      end

      it "removes the counts, turning the hash into an array" do
        expect(@database['a']).to eq ["a"]
        expect(@database['k']).to eq ["a"]
        expect(@database['z']).to eq ['b', 'a']
      end
    end

    describe "#prep_database" do
      before :each do
        @database = propass.prep_database
      end

      it "reads the database, sorts it, and removes counts" do
        expect(@database['a']).to eq ["a"]
        expect(@database['k']).to eq ["a"]
        expect(@database['z']).to eq ['a', 'b']
      end
    end
  end

  describe "letter picking" do
    before :each do
      propass.prep_database
    end

    describe "#possible_next_letters" do
      it 'picks the next most common letters' do
        expect(propass.possible_next_letters('z')).to eq ["a", "b"]
      end
    end

    describe "#most_common_next_letter" do
      it 'picks the next best letter' do
        expect(propass.most_common_next_letter('z')).to eq 'a'
      end
    end

    describe "#common_next_letter" do
      it 'picks the next best letter from a subset of the most common options' do
        expect(propass.common_next_letter('z')).to be_one_of(['a','b'])
      end
    end
  end
end



