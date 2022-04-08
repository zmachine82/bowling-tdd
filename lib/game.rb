class Game 

    def initialize
        @points = 0
        @frames = Array.new(9) { |i| Frame.new }
        @frames.push(TenthFrame.new)
        @current_frame = @frames[0]

        @current_roll = 1
    end

    def roll(rolled)
        if @current_frame.complete?
            current_frame_index = @frames.find_index(@current_frame)
            @current_frame = @frames[current_frame_index + 1]
        end

        @current_frame.roll(rolled)

    end

    def score
        total = 0
        @frames.each_with_index do |frame, current_index|
            total += frame.points

            if frame.strike? && current_index != 9
                next_frame = @frames[current_index + 1]
                if current_index != 8
                    total += next_frame.points

                else
                    total += next_frame.first_two_rolls
                end
                if next_frame.strike? && current_index != 8
                    next_frame = @frames[current_index + 2]
                    total += next_frame.first_roll
                end
            end

            if frame.spare? && current_index != 9
              next_frame = @frames[current_index + 1]
              total += next_frame.first_roll
            end
        end
       total

    end

    
    
end


class Frame
    attr_reader :points
  
  def initialize
    @rolls = []
  end
  
  def roll(rolled)
    @rolls.push(rolled)
  
  end

  def spare? 
    @rolls.length == 2 && points == 10
  end
  
  def strike?
    points === 10 && @rolls.length == 1
  end

  def complete? 
     points === 10 || @rolls.length === 2
  end

  def points
    @rolls.sum
  end
  
  def first_roll
    @rolls[0]
  end
  

end

class TenthFrame < Frame

    def complete? 
        (strike? && @rolls.length == 3) ||
        (spare? && @rolls.length == 3) ||
        (!strike? && !spare? && @rolls.length == 2)
        
         
    end

    def strike?
        @rolls[0] == 10
    end

    def first_two_rolls
        @rolls[0] + @rolls[1]
    end



end


# 1 frame class, positive here is that you can test this class directly
# 2 keep an array of all the rolls and just figure frames later




