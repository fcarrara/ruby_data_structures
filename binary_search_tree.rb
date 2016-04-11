class BinarySearchTree

  class Node

    attr_accessor :value, :left, :right

    def initialize(value)
      @value = value
      @left = nil
      @right = nil
    end

    def insert(value)
      if value <= @value
        @left.nil? ? @left = Node.new(value) : @left.insert(value)
      else
        @right.nil? ? @right = Node.new(value) : @right.insert(value)
      end
    end

    def to_a
      @left.to_a + [@value] + @right.to_a
    end

  end

  def build_tree(list)
    root = Node.new(list.shift)
    list.each { |i| root.insert(i) }
    root
  end

  def breadth_first_search(root, target)
    queue = [root]

    while !queue.empty?
      current = queue.shift

      # Found?
      return current if current.value == target

      # Add both children to queue
      queue << current.left if !current.left.nil?
      queue << current.right if !current.right.nil? 
        
    end
    nil  
  end

  def depth_first_search(root, target)
    stack = [root]

    while !stack.empty?
      current = stack.pop

      #Found?
      return current if current.value == target

      # Add both children to stack
      stack << current.left if !current.left.nil?
      stack << current.right if !current.right.nil?
    end
    nil
  end

  def dfs_rec(root, target)
    return nil if root.nil?
    return root if root.value == target
    
    left = dfs_rec(root.left,target)
    right = dfs_rec(root.right,target)
    left or right
  end

end

list = [3,5,1,2,8,2,9]
bst = BinarySearchTree.new
tree = bst.build_tree(list)
puts bst.breadth_first_search(tree, 1).inspect
puts bst.depth_first_search(tree, 8).inspect
puts bst.dfs_rec(tree,9).inspect

