require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  
  def move(game, mark)
    
    root_node = TicTacToeNode.new(game.board,mark)
    
    # I am going to check all of the root node's children to make sure
    # that there is not an immediate move that is a winner or a move that will be a loser
    
    # moves = []
    # If there are any nodes that can win, select any of those and add it to moves
    
    
    # moves: [Node1, Node2]
    
    # If there is NO chance of winning AKA moves is empty after checking for winning_nodes?(mark)
    # then select non-losing nodes AKA !losing_nodes? and do those moves
    
    root_node.children.each do |child|
      if child.winning_node?(mark)
        puts "FIRST"
        return child.prev_move_pos
      end
    end
    
    ## If it reaches past this stage, there are no winning nodes. Suck it.
    
    root_node.children.each do |child|
      if !child.losing_node?(mark)
        puts "SECOND"
        return child.prev_move_pos
      end
    end
    
    raise "ERROR"
 
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
