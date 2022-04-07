require_relative './lib/game.rb'

def puts_score(game)
    puts game.score
    if game.complete
        return
    end
    get_roll(game)
end

def get_roll(game)
    puts 'What is the roll?'
    game.roll(gets.chomp.to_i)
    puts_score(game)
end


game = Game.new

get_roll(game)


