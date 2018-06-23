require 'byebug'
class PolyTreeNode
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end
  
  def children
    @children
  end
  
  def value
    @value
  end
  
  def parent=(node)
    @parent.children.delete(self) if @parent != nil

    @parent = node

    node.children << self unless node.nil? || node.children.include?(self)
  end
  
  def add_child(child_node)
    child_node.parent = self
  end
  
  def remove_child(child_node)
    raise "Node is not a child!" if child_node.parent.nil?
    child_node.parent = nil
  end
  
  def dfs(target)
    if @value == target  
      return self 
    else
      @children.each do |node|
        result = node.dfs(target)
        return result unless result.nil? 
      end
    end
    return nil
  end
  
  def bfs(target)
    results = [self]
    until results.empty?
      return results.first if results.first.value == target
      
      results += results.first.children
      
      results.shift
    end
    
    return nil
  end
  
  # attr_accessor :value, :parent, :children
end

# node = PolyTreeNode.new(0)
# node.parent(nil)