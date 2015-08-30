require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  
  def move(game, mark)
    
    root_node = TicTacToeNode.new(game.board,mark)
    
    # I am going to check all of the root node's children to make sure
    # that there is not an immediate move that is a winner or a move that will be a loser
    
    root_node.children.each do |child|
      if child.board.over? && child.board.winner == mark
        return child.prev_move_pos
      end
    end
    '''
    if root_node.losing_node(swap(mark))
      root_node.children.each do |child|
        return child.prev_move_pos if !child.losing_node?(mark)
      end
    end'''
    
    if TicTacToeNode.new(game.board, swap(mark)).losing_node?(mark)#If the opponent had one more move, he/she would beat the computer
      puts "TEST 1"
      root_node.children.each do |child|
        return child.prev_move_pos if !child.losing_node?(mark)
      end
      raise "Error"
    end
    #Checking if move will cause a loser
    
    
    root_node.children.each do |child|
      if child.board.over? && child.board.winner == swap(mark)
        return child.prev_move_pos
      end
    end
    #Current board state.
    
    if root_node.winning_node?(mark)
      #There is a winning node in the current state!
      #BFS method?
      bfs_array = [root_node]
      while true
        bfs_array.each do |root|
          if root.board.over? && root.board.winner == mark
            return root.prev_move_pos
          end
          bfs_array += root.children
        end
      end
    
            
        '''
    
    root_node.children.each do |child|
      #Search for the winners
      if child.winning_node?(mark)
        #There is a winner,now we gotta search for it.
     '''   
    end
  end
  
  def swap(mark)
    if mark == :x
      mark = :o
    else
      mark = :x
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
