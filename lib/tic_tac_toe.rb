require 'pry'
require 'awesome_print'

class TicTacToe 

    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6],
    ]

    def initialize(board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '])
        @board = board
    end

    def display_board 
        puts "#{@board[0]} | #{@board[1]} | #{@board[2]}"
        puts "#{@board[3]} | #{@board[4]} | #{@board[5]}"
        puts "#{@board[6]} | #{@board[7]} | #{@board[8]}"
        
    end

    def input_to_index(input) 
        input - 1
    end

    def move(index, player_token="X") 
        @board[index] = player_token    
    end

    def position_taken(index)
        if @board[index] == ' '
            return false
        else 
            return true
        end
    end

    def valid_move(index) 
        if !position_taken(index) && @board[index]
            return true
        else 
            return false
        end
    end

    def turn_count 
        
        turns = @board.filter {|turn| turn != ' '}.length
        return turns 
    end

    def current_player 
        if turn_count.odd? 
            return "X"
        elsif turn_count.even?
            return "O"
        end
    end

    def won 
        winning_combo = WIN_COMBINATIONS.find do |combo| 
            
            if [@board[combo[0]], @board[combo[1]], @board[combo[2]]] == ["X", "X", "X"]
                
                return combo
            elsif [@board[combo[0]], @board[combo[1]], @board[combo[2]]] == ["O", "O", "O"] 
                
                return combo
            else 
                # ap "no winner yet..."
                return false
            end

            display_board()
        end
    end

    def full 
        return @board.filter {|space| space == ' '}.empty?
    end

    def draw 
        if full() && !won()
            return true
        else
            return false
        end
    end

    def over 
        if full() || won()
            return true
        else
            return false
        end
    end

    def winner 
        if won() 
            if current_player == "O" 
                return "X"
            elsif current_player == "X"
                return "O"
            end
        end
            
    end

    def turn 
        puts "Choose your next move: Type a number between 1 and 9"
        
        display_board()
        index = input_to_index(gets.chomp().to_i)
        winner = current_player()
        if valid_move(index) 
            move(index, current_player)

            # ap won()
            # if won()
            #     ap "#{winner} Wins!!"
            # end
            # if full() 
            #     ap "Full board! Start over?"
            # end
        else
            puts "Invalid move"
            turn()
        end
    end

    def play 
        while !over() do
            turn()
        end

        if won() 
            ap "CONGRATULATIONS!"
            display_board()
            ap "#{winner()} Wins!!"
        elsif draw() 
            ap "It's a draw"
        end  
    end
end

