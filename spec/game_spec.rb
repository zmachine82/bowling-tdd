require_relative '../lib/game'

RSpec.describe Game do

    before(:each) do
        @game = Game.new
    end

    it 'should handle gutter balls' do
        roll_ball(1, 0)
        expect(@game.score).to eq 0
    end

    it 'should handle all gutter balls' do
        roll_ball(20, 0)
        expect(@game.score).to eq 0
    end

    it 'should handle all rolls no strikes or spares' do
        roll_ball(20, 1)
        expect(@game.score).to eq 20
    end

    it 'should handle strikes' do
        roll_ball(1, 10)

        roll_ball(2, 1)

        expect(@game.score).to eq 14
    end

    it 'should handle 3 strikes' do
        roll_ball(3, 10)
      

        roll_ball(2, 1)

        expect(@game.score).to eq 65
    end

    it 'should handle spares' do
        roll_ball(2, 5)
        # 11
        # 2
        # 13

        roll_ball(2, 1)

        expect(@game.score).to eq 13
    end

    it 'should handle spares with following strikes' do
        roll_ball(2, 5)
        # 20
        # 12
        # 2

        roll_ball(1, 10)
        roll_ball(2, 1)

        expect(@game.score).to eq 34
    end

    it 'should handle all strikes' do
        roll_ball(12, 10)
   

        expect(@game.score).to eq 300
    end
    
    
    
    
    private

    def roll_ball(num, pins)
        num.times do
            @game.roll(pins)
        end
    end
end 


RSpec.describe Frame do
    before(:each) do
        @frame = Frame.new
    end
    it 'should be not complete by default' do

       expect(@frame.complete?).to eq false
    end

    it 'should be complete once 2 rolls happen and there are still pins standing' do

        @frame.roll(1)
        expect(@frame.complete?).to eq false
        
        @frame.roll(1)
 
        expect(@frame.complete?).to eq true
    end
    
    it 'should be complete after a strike' do

        @frame.roll(10)
    
        expect(@frame.complete?).to eq true
        expect(@frame.strike?).to eq true
        expect(@frame.spare?).to eq false
    end

    it 'should be complete after a spare' do

        @frame.roll(9)
        @frame.roll(1)
    
        expect(@frame.complete?).to eq true
        expect(@frame.spare?).to eq true
        expect(@frame.strike?).to eq false
    end

    it 'should return first roll points' do
        @frame.roll(9)
        @frame.roll(1)
    
        expect(@frame.first_roll).to eq 9
    end


  
end


RSpec.describe TenthFrame do
    before(:each) do
        @frame = TenthFrame.new
    end

    
    it 'should be complete if no strike or spare' do
        roll_ball(2,1)
        expect(@frame.complete?).to eq true
    end

    it 'should be not be complete if strike' do
        roll_ball(1,10)
        expect(@frame.complete?).to eq false
    end

    it 'should be not be complete if 2 strikes' do
        roll_ball(2,10)
        expect(@frame.complete?).to eq false
    end

    it 'should be be complete if 3 strikes' do
        roll_ball(3,10)
        expect(@frame.complete?).to eq true
    end

    
    it 'should be not be complete if spare' do
        roll_ball(2,5)
        expect(@frame.complete?).to eq false
    end

    private 
    def roll_ball(num, pins)
        num.times do
            @frame.roll(pins)
        end
    end
end