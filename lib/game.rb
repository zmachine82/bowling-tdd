class Game
    def initialize
        @score = 0
        @rolls = []
    end
    
    def roll(pins)
        @rolls.push(pins)
      
    end

    def complete
        @frames_completed == 10
    end

    def score
        @score = 0
        frame_index = 0
        @frames_completed = 0
        10.times do
            if @rolls[frame_index] == nil
                next
            end

            if is_strike(frame_index)
                @score += 10 + strike_bonus(frame_index)
                frame_index += 1
                @frames_completed += 1

            elsif is_spare(frame_index)
                @score += 10 + spare_bonus(frame_index)
                frame_index += 2
                
            else
                @score += @rolls[frame_index] 
                if @rolls[frame_index + 1]
                    @score += @rolls[frame_index + 1]
                end
                frame_index += 2
            end
            @frames_completed += 1

        end
    
        @score
    end

    private
        def is_strike(frame_index)
            @rolls[frame_index] == 10
        end

        def is_spare(frame_index)
            if @rolls[frame_index] && @rolls[frame_index + 1]

               return @rolls[frame_index] + @rolls[frame_index + 1] == 10
            end
            false
        end

        def strike_bonus(frame_index)
            (@rolls[frame_index + 1] || 0) + (@rolls[frame_index + 2] || 0)
        end

        def spare_bonus(frame_index)
            @rolls[frame_index + 2] || 0
        end

end


class Frame
    
end