class Game
    attr_accessor :player_1, :player_2, :numbers, :available_numbers

    def initialize(player_1, player_2)
        @player_1 = player_1
        @player_2 = player_2
        @numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        @available_numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]

        puts "#{player_1.name} vs #{player_2.name}"
    end

    def status
        "
            +---+---+---+
            | #{numbers[0]} | #{numbers[1]} | #{numbers[2]} |
            +---+---+---+
            | #{numbers[3]} | #{numbers[4]} | #{numbers[5]} |
            +---+---+---+
            | #{numbers[6]} | #{numbers[7]} | #{numbers[8]} |
            +---+---+---+
        "
    end
end

class Player

    attr_accessor :switch
    attr_reader :name, :selection

    @@switch = 'Off'

    def initialize(name)
        @name = name
        @selection = []

        puts "#{name} ready"
    end

    def play(game)
        print "#{name} to select a number: "
        selected = gets.chomp.to_i

        if (game.available_numbers.include?(selected)) # can't pick same number more than once
            selection << selected
            print "#{name} select: #{selected}\n"
            index = game.numbers.find_index(selected)
            
            if (name == 'Player 1')
                game.numbers[index] = 'X'
            else
                game.numbers[index] = 'O'
            end

            # remove the selected number
            game.available_numbers.filter! {|number| number != selected}
        else
            print "Sorry, #{selected} is not available.\n"
            self.play(game)
        end
    end

    def self.switch
        @@switch
    end

    def self.switch_on
        @@switch = 'On'
    end

    def self.switch_off
        @@switch = 'Off'
    end
end

def win?(player_selection)
    winning_combinations = [
        [1, 2, 3], [4, 5, 6], [7, 8, 9],
        [1, 4, 7], [2, 5, 8], [3, 6, 9],
        [1, 5, 9], [3, 5, 7]
    ]

    step_1 = winning_combinations.map do | item |
        item.map do | i |
            player_selection.include?(i)
        end
    end

    step_2 = step_1.map do | item |
        item.all? { |i| i }
    end

    step_2.any? { |i| i }
end

p1 = Player.new('Player 1')
p2 = Player.new('Player 2')
game = Game.new(p1, p2)

puts

puts game.status
puts

while true

    if game.available_numbers.count != 0
        if Player.switch == 'Off'
            p1.play(game)
            puts game.status
            puts
            
            if win?(game.player_1.selection)
                puts "#{game.player_1.name} won !!"
                puts 'End of Game'
                break
            else
                Player.switch_on
            end
            
        else
            p2.play(game)
            puts game.status
            puts

            if win?(game.player_2.selection)
                puts "#{game.player_2.name} won !!"
                puts "End of Game"
                break
            else
                Player.switch_off
            end

        end
    else
        puts "No winner"
        puts 'End of Game'
        break
    end
end