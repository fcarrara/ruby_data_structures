class Node
  include Enumerable

  attr_reader :value, :children, :parent

  def initialize(value, parent=nil)
    @value = value
    @children = []
    @parent = parent
  end

  def each(&block)
    block.call(self)
  end

end