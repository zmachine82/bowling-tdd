require_relative '../lib/game'

RSpec.describe Game do
    before do
        @game = Game.new
    end
    context 'all gutter game' do
        it 'should return final score of 0' do
            roll_many(20, 0)
            
            expect(@game.score).to eq 0
        end
    end

    context 'no strike/spare game' do
        it 'should return final score of 0' do
            roll_many(20, 1)

            expect(@game.score).to eq 20
        end
    end

    context 'a spare' do 
        it 'should return score plus next roll' do
            roll_spare
            @game.roll(5)
            roll_many(17, 0)
            
            expect(@game.score).to eq 20
        end
    end

    context 'a strike' do 
        it 'should return score plus next 2 rolls' do
            @game.roll(10)
            @game.roll(1)
            @game.roll(5)
            roll_many(16, 0)

            expect(@game.score).to eq 22
        end

        it 'should return score plus next 2 rolls even if 0' do
            @game.roll(10)
            roll_many(18, 0)

            expect(@game.score).to eq 10
        end
    end

    context 'a perfect game' do 
        it 'should return perfect score' do
            roll_many(12, 10)
            

            expect(@game.score).to eq 300
        end
    end

    context 'mid game' do
        it 'should return score' do
            roll_many(6, 4)
            expect(@game.score).to eq 24
        end
    end

    private


    def roll_many(rolls, pins)
        rolls.times do
            @game.roll(pins)
        end
    end

    def roll_spare
        @game.roll(9)
        @game.roll(1)
    end
end