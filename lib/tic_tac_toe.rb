require 'pry'

class TicTacToe
    WIN_COMBINATIONS = [
        [0,1,2], 
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]                         
    ]
    def initialize 
        @board =  Array.new(9, " ")
    end

    def display_board 
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(user_input)
        user_input.to_i - 1
    end

    def move(position, player)
        @board[position] = player
    end

    def position_taken?(index)
        @board[index] != " "
    end

    def valid_move?(index)
        index.between?(0,8) && position_taken?(index) == false
    end

    def turn_count
        @board.count {|player| player == "X" || player == "O"}
    end

    def current_player
        if turn_count.even?
            "X"
        else
            "O"
        end
    end

    def turn 
        user_input = gets.strip
        index = input_to_index(user_input)
        player = current_player
        if valid_move?(index)
            move(index, player)
            display_board
        else
            turn
        end
    end

    def won?
        WIN_COMBINATIONS.detect do |win_combo|
            # binding.pry
            @board[win_combo[0]]== "X" &&
            @board[win_combo[1]]== "X" && 
            @board[win_combo[2]]== "X" || 
            @board[win_combo[0]]== "O" && 
            @board[win_combo[1]]== "O" && 
            @board[win_combo[2]]== "O" 
        end
    end

    def full?
        @board.all?{|index| index == "X" || index == "O"}
    end

    def draw?
        if !won? && full?
            true 
        else
            false
        end

    end

    def over?
        if draw?||won?
            true
        else
            false
        end
    end

    def winner
        index = won?

        if index
            @board[index[0]]
        end
    end

    def play
        until over?
            turn 
        end
        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end

end

