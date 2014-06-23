require 'rspec'
require 'spec_helper'
require './codebreaker'

module Codebreaker

  describe Game do
    let(:game) { Game.new }

    describe '#start' do

      it 'generates secret code' do
        expect(game).to receive(:generate)
        game.start('User')
      end

      before(:each) { game.start('User') }

      it 'saves 4 numbers secret code' do
        expect(game.instance_variable_get(:@secret_code)).to have(4).items
      end

      it 'saves secret code with numbers from 1 to 6' do
        expect(game.instance_variable_get(:@secret_code)).to in_range(1,6)
      end

      it 'define user' do
        expect(game.user_name).to eq('User')
      end

    end

    describe '#game' do
      before(:each) do
        game.start('User')
        game.instance_variable_set(:@secret_code, [1,2,3,4])
      end

      guess = [[1,2,5,6], [1,2,5,3], [4,3,2,1], [5,5,5,5], [1,2,3,4]]
      results = ['++', '++-', '----', '', '++++']

      5.times do |i|
        it 'match guess' do
          expect(game.match_guess(*guess[i])).to eq(results[i])
        end
      end

      it 'codebreaker win' do
        game.match_guess(1,2,3,4)
        expect(game.is_started).to eq(false)
        expect(game.get_last_score.result).to eq('You win!')
      end

      it 'codebreaker loose' do
        10.times { game.match_guess(1,1,1,1) }
        expect(game.is_started).to eq(false)
        expect(game.get_last_score.result).to eq('You loose')
      end

      it 'request a hint' do
        expect(game.get_hint).to in_array([1,2,3,4])
      end

    end

    describe '#save score' do
      before(:each) do
        game.start('User')
        game.instance_variable_set(:@secret_code, [1,2,3,4])
        game.match_guess(5,5,5,5)
        game.match_guess(1,2,3,4)
      end

      it 'save user name' do
        expect(game.get_last_score.user).to eq('User')
      end

      it 'save score' do
        expect(game.get_last_score.attempts).to eq(2)
      end

      it 'save result' do
        expect(game.get_last_score.result).to eq('You win!')
      end

    end

  end
end