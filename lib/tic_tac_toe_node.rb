require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :prev_move_pos
  attr_accessor :next_mover_mark

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)

    return false if board.over? && (board.winner == evaluator || board.winner == nil)
    return true if board.over? && board.winner == swap(evaluator)

    #No matter what move you make, you will lose. AKA all children will lose.
    if next_mover_mark == evaluator
      children.each do |child|
        # If one child is not a losing node, then this will not be a losing node.
        # We need to check if ALL children are losing nodes
        return false if !child.losing_node?(evaluator)
      end
      return true
          #If I swap, then the reverse. Evaluating if child has a losing node if it's the other person's move
          #Need to check if the opponent can make a move to win the game. Losi
        
    else #The opponent's turn IF NEXT_MOVER_MARK IS NOT YOU
      #if each children's game is over and the winner is the evaluator
      children.each do |child|
        return true if child.board.over? && child.board.winner == swap(evaluator)
      end
      return false
    end
  end

  def winning_node?(evaluator)

    return true if board.over? && board.winner == evaluator
    return false if board.over? && (board.winner != evaluator || board.winner == nil)
    
    if next_mover_mark == evaluator
      children.each do |child|
        #return true if child.board.over? && child.board.winner == evaluator
        return child.winning_node?(evaluator)
      end
      
      return false
      
    else
      
      children.each do |child|
        return true if child.winning_node?(evaluator)
      end
      return false
      
    end
  
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children_array = []
    board.rows.each_with_index do |row,idx|
      row.each_with_index do |el, idx2|
        if el.nil?
          new_board = board.dup
          new_board.rows[idx][idx2] = next_mover_mark
          children_array << TicTacToeNode.new(new_board, swap(next_mover_mark), [idx,idx2])
        end
      end
    end
    children_array
  end

  def swap(mark)
    if mark == :x
      mark = :o
    else
      mark = :x
    end
  end
  
end
