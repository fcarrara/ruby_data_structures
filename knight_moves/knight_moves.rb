require './node'

class KnightMoves

  attr_reader :node, :visited

  def initialize(node)
    @root = Node.new(node)
    @visited = [node]
  end

  def build_children(node)
    value = node.value
    movements = [[value[0] - 1, value[1] - 2], [value[0] - 2, value[1] - 1],
                 [value[0] - 2, value[1] + 1], [value[0] + 1, value[1] - 2],
                 [value[0] - 1, value[1] + 2], [value[0] + 2, value[1] - 1],
                 [value[0] + 2, value[1] + 1], [value[0] + 1, value[1] + 2]]

    # Add the 8 possible movements as children
    movements.each { |movement| add_if_valid(node, movement) }
    
  end

  # Add to the tree nodes that are not visited yet and don't go off the board
  def add_if_valid(root, node)
    if !@visited.include?(node) && node[0].between?(0,7) && node[1].between?(0,7) 
      root.children << Node.new(node, root)
      @visited << node
    end
  end

  def build_tree
    queue = [@root]

    # First make children of root
    build_children(@root)

    # Then the rest of the tree
    while !queue.empty?
      current = queue.shift
      current.children.each do |node| 
        queue << node
        build_children(node)
      end
    end
  end

  # Breadth-first search algorithm
  def trace_path(target)
    queue = [@root]
    path = []

    while !queue.empty?
      current = queue.shift
      
      # Found?
      if current.value == target
        path << current.value

        # Create parents path
        current_parent = current.parent
        while !current_parent.nil?
          path << current_parent.value
          current_parent = current_parent.parent
        end

        puts "You made it in #{path.size - 1} moves! Here's your path:"
        path.reverse.each { |n| puts "#{n}" }
        return
      end

      current.children.each { |children| queue << children}

    end
  end

end
 

def knight_moves(start_position, end_position)
  tree = KnightMoves.new(start_position)
  tree.build_tree
  tree.trace_path(end_position)
end

puts knight_moves([0,2],[7,7])