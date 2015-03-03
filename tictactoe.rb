# tic tac toe console game in Ruby
# Author :  Dewang Shahu 
# Date    : 27 Feb 2015
#
require 'pry'

#constants
WINNING_LINES = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]

#methods initialize board
def initialize_board
    board = {}
    (1..9).each {|position| board[position] = ' '}
    board
end

#method to accept position and marker values to draw the board
def draw_board(board)
  system 'clear'
  puts " #{board[1]} | #{board[2]} | #{board[3]} "
  puts "-----------"
  puts " #{board[4]} | #{board[5]} | #{board[6]} "
  puts "-----------"
  puts " #{board[7]} | #{board[8]} | #{board[9]} "
end

def empty_positions(board)
  board.select{|key, value| value == ' ' }.keys
end

#player picks a square
def player_pick_square(board)
  valid_choice = false
  begin
    puts "Pick a square (1-9): "
    position = gets.chomp.to_i
    if board.keys.include?(position)
      if board[position] == ' '
          board[position] = 'X'
          valid_choice = true
        else
          puts "Position is already filled..please pick another square"
      end
    else
        puts "Please pick between square number 1-9"
    end
  end while !valid_choice  
end

#computer picks a square
def computer_pick_square(board)    
  position = nil
  WINNING_LINES.each do |line|
    current_grid_status = {line[0] => board[line[0]], line[1] => board[line[1]], line[2] => board[line[2]]}
    found_two_in_a_row = two_in_a_row(current_grid_status, 'X')
    if found_two_in_a_row
      position = found_two_in_a_row
    end
  end
    
  if !position
      position = empty_positions(board).sample
  end
  board[position] = 'O' 
end

#methods to analyse results based on the current positions, it returns the result
def check_winner(board)
  WINNING_LINES.each do |line|
    if board[line[0]] == 'X' && board[line[1]] == 'X' && board[line[2]] == 'X'
      return "Player"
    elsif board[line[0]] == 'O' && board[line[1]] == 'O' && board[line[2]] == 'O'
      return "Computer"
    end
  end  
  return nil
end

# checks to see if two in a row
def two_in_a_row(current_grid_status, mrkr)
  if current_grid_status.values.count(mrkr) == 2
    current_grid_status.select{|k,v| v == ' '}.keys.first
  else
    false
  end
end

board = initialize_board
draw_board(board)

begin
  player_pick_square(board)
  draw_board(board)
  computer_pick_square(board)
  draw_board(board)
  winner = check_winner(board)
end until winner || empty_positions(board).empty?

if winner != nil
  puts "#{winner} won!"
else
  puts "It's a tie"
end
  