# tic tac toe console game in Ruby
# Author :  Dewang Shahu 
# Date    : 27 Feb 2015
#
require 'pry'

#constants
HORIZONTAL_LINE = '-'
VERTICAL_LINE = "|"
LINE_JOINT = "+"
WIDTH = 17
HEIGHT = 11
PLAYER_AND_MARKER = {'X' => 'Player', 'O' => 'Computer'}
VALID_CURRENT_POSITIONS = [1,2,3,4,5,6,7,8,9]

#method to accept position and marker values to draw the board
def draw_board(grid)
  for line_no in 0..10 
    for column_no in 0..16
          if (line_no != 3 && column_no != 5) && (line_no != 7 && column_no != 11)
              grid[line_no][column_no] = ' '
            else
              grid[line_no][column_no] = '|'
          end
      
          if line_no == 3 || line_no == 7
            if column_no == 5 || column_no == 11
                grid[line_no][column_no] = LINE_JOINT
              else
                grid[line_no][column_no] = "-"
            end
      end end
  end
end

#methods fills a 3x3 array of markers to fill current positions
def fill_current_positions(grid, current_positions, position, marker)
    case position
    when 1
      #pry.binding
      grid[1][2] = marker
      current_positions[0][0] = marker
    when 2
      grid[1][8] = marker
      current_positions[0][1] = marker
    when 3
      grid[1][14] = marker
      current_positions[0][2] = marker
    when 4
      grid[5][2] = marker
      current_positions[1][0] = marker
    when 5
      grid[5][8] = marker  
      current_positions[1][1] = marker
    when 6
      grid[5][14] = marker
      current_positions[1][2] = marker
    when 7
      grid[9][2] = marker
      current_positions[2][0] = marker
    when 8
      grid[9][8] = marker
      current_positions[2][1] = marker
    when 9
      grid[9][14] = marker    
      current_positions[2][2] = marker
    end
end

#methods to draw the game board
def draw_grid_current_positions(grid)
  for line_number in 0..10 
      for column_number in 0..16 
          print grid[line_number-1][column_number-1]
      end
      puts "\n"
  end
end

#methods to check the currently occupied positions to reject user\computer's selection for already taken\filled position
def check_current_positions(current_positions, position)
  case position
  when 1
      if current_positions[0][0] != nil
          return false
         else
          return true
      end
  when 2
      if current_positions[0][1] != nil
          return false
         else
          return true
      end
   when 3
      if current_positions[0][2] != nil
          return false
         else
          return true
      end 
    when 4
    if current_positions[1][0] != nil
          return false
       else
          return true
      end
    when 5
    if current_positions[1][1] != nil
          return false
       else
          return true
      end
    when 6
    if current_positions[1][2] != nil
          return false
       else
          return true
      end
    when 7
    if current_positions[2][0] != nil
          return false
       else
          return true
      end
    when 8
    if current_positions[2][1] != nil
          return false
       else
          return true
      end
    when 9
    if current_positions[2][2] != nil
          return false
        else
          return true
      end
  end
end

#methods to analyse results based on the current positions, it returns the result
def analyse_results(current_positions)
  outcome = "pending"
  PLAYER_AND_MARKER.each do |marker, current_player|
    current_positions.each.with_index do |current_content, index|
      if current_content[0] == marker && current_content[1] == marker && current_content[2] == marker
          return current_player + " won!!!"
      end
    end
  end

  PLAYER_AND_MARKER.each do |marker, current_player|
        if current_positions[0][0] == marker && current_positions[1][0] == marker && current_positions[2][0] == marker
            return current_player + " won!!!"
        elsif current_positions[0][1] == marker && current_positions[1][1] == marker && current_positions[2][1] == marker
            return current_player + " won!!!"
        elsif current_positions[0][2] == marker && current_positions[1][2] == marker && current_positions[2][2] == marker
            return current_player + " won!!!"
        elsif current_positions[0][0] == marker && current_positions[1][1] == marker && current_positions[2][2] == marker
            return current_player + " won!!!"
        elsif current_positions[0][2] == marker && current_positions[1][1] == marker && current_positions[2][0] == marker
            return current_player + " won!!!"
        else
            return outcome
        end
    end
end



begin
  grid  = Array.new(WIDTH){Array.new(HEIGHT)}
  current_positions = Array.new(3){Array.new(3)}
  another_round = 'y'
  draw_board(grid)
  user_position = 0
  computer_position = 0
  position_count = 0

  #loop till user selects not play the game anymore
   while another_round == 'y' do
    #loop to keep getting user position input in case of user selects an already taken position
    loop do
        puts "Choose a position from (1 to 9) to place a piece : "
        user_position = gets.chomp
        if !check_current_positions(current_positions,user_position.to_i)
            puts "*** This position is already filled..please try again"
          else
            break
        end
    end
    
    fill_current_positions(grid, current_positions, user_position.to_i, PLAYER_AND_MARKER.key('Player'))
    position_count += 1
    outcome = analyse_results(current_positions)

    if position_count < 9 && outcome == 'pending'
        #loop to keep getting computer's randomly selected position input in case of user selects an already taken position
        loop do
              computer_position = VALID_CURRENT_POSITIONS.sample
              if !check_current_positions(current_positions,computer_position.to_i)
                next
              else
                break
              end
        end

        fill_current_positions(grid, current_positions, computer_position.to_i, PLAYER_AND_MARKER.key('Computer'))
        position_count += 1
    end
    draw_grid_current_positions(grid)
    outcome = analyse_results(current_positions)

    if outcome != 'pending' 
        puts outcome
    elsif outcome == 'pending' && position_count == 9
        puts "It's a tie..."
    end

    if position_count >= 9 || outcome != 'pending'
        puts "Play again?(y/n)"
        another_round = gets.chomp.downcase
        if another_round == 'y'
            draw_board(grid)
            current_positions = Array.new(3){Array.new(3)}
            user_position = 0
            position_count = 0
            computer_position = 0
          else
            break
        end
      end
  end
  
end