require_relative '00_tree_node'

class KnightPathFinder
  attr_reader :pos, :visited_positions, :root
  
  def initialize(pos)
    @pos = pos
    @visited_positions = [pos]
  end
  
  def valid_moves(pos)
    valid_moves = possible_moves(pos).select {|move| move[0].between?(0, 7) && move[1].between?(0, 7)}
    valid_moves.reject {|move| visited_positions.include?(move)}
  end
  
  def new_move_positions(pos)
    new_moves = valid_moves(pos)
    new_moves.each {|move| visited_positions << move}
    new_moves
  end
  
  def possible_moves(pos)
    possible_moves = []
    
    possible_moves << [pos[0] + 2, pos[1] + 1]
    possible_moves << [pos[0] + 2, pos[1] - 1]
    possible_moves << [pos[0] + 1, pos[1] + 2]
    possible_moves << [pos[0] + 1, pos[1] - 2]
    possible_moves << [pos[0] - 2, pos[1] + 1]
    possible_moves << [pos[0] - 2, pos[1] - 1]
    possible_moves << [pos[0] - 1, pos[1] + 2]
    possible_moves << [pos[0] - 1, pos[1] - 2]
    
    possible_moves
  end
  
  def build_move_tree
    @root = PolyTreeNode.new(pos)
    
    queue = []
    queue << @root
    
    until queue.empty?
      new_move_positions(queue.last.value).each do |pos|
        new_node = PolyTreeNode.new(pos)
        queue << new_node
        queue.first.add_child(new_node)
        p queue.last.value
      end
      queue.shift

    end
    @root
  end
  
#   def find_path(end_pos)
#     self.build_move_tree
#     node = @root.dfs(end_pos)
#     node.value
#     # # @root = self.build_move_tree.bfs(end_pos)
#     # trace_path_back(node)
#   end
# 
#   def trace_path_back(node)
#     current = node
#     path = []
#     until current.parent == nil
#       path << current.value
#       current = current.parent
#     end
#     return path
#   end
end

kpf = KnightPathFinder.new([0,0])

kpf.build_move_tree