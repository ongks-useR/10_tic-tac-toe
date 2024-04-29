module TicTakToe
    def self.play
        # initialize game and player instances
        game = Game.new
        p1 = Player.new(1)
        p2 = Player.new(2)

        puts game.status
        
        while true

            if game.available_numbers.count != 0
                if Player.status == 'On'
                    p1.play(game)
                    puts game.status
                    if game.win?(p1)
                        puts "Congratulation, #{p1.name} won !!"
                        puts "End of Game"
                        break
                    else
                        Player.status_update
                    end
                else
                    p2.play(game)
                    puts game.status
                    if game.win?(p2)
                        puts "Congratulation, #{p2.name} won !!"
                        puts "End of Game"
                        break
                    else
                        Player.status_update
                    end
                end
            else
                puts "No winner"
                puts 'End of Game'
                break
            end
        end
    end

    class Game
        attr_accessor :numbers, :available_numbers
    
        def initialize
            @numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9] 
            @available_numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9] 
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

        def win?(player)
            numbers = [
                [1, 2, 3], [4, 5, 6], [7, 8, 9],
                [1, 4, 7], [2, 5, 8], [3, 6, 9],
                [1, 5, 9], [3, 5, 7]
            ]
    
            result = numbers.map do | number |
                (number - player.selection).empty?
            end
    
            result.any? {|item| item}
        end
    end
    
    class Player
        attr_reader :name, :selection
        @@switch = 'On'
    
        def initialize(number)
            @name = "Player #{number}"
            @selection = []
        end
    
        def play(game)
            print "#{name} to choose a number from #{game.available_numbers}: "
            selected = gets.chomp.to_i
    
            if game.available_numbers.include?(selected)
    
                selection << selected
                print "#{name} choose: [ #{selected} ]\n"
                index = game.numbers.find_index(selected)
                
                if name == 'Player 1'
                    game.numbers[index] = 'O'
                else
                    game.numbers[index] = 'X'
                end
    
                game.available_numbers.filter! {|number| number != selected}
    
            else
                puts "Sorry, #{selected} is not available."
                self.play(game)
            end
        end
    
        def self.status
            @@switch
        end
    
        def self.status_update
            if self.status == 'On'
                @@switch = 'Off'
            else
                @@switch = 'On'
            end
        end
    end
end

TicTakToe.play