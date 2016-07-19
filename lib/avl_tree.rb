class Node
  attr_reader :val, :height, :left, :right
  attr_writer :height, :left, :right

  def initialize(val)
    @val = val
    @height = 1
    @left = nil
    @right = nil
  end

  def inspect
    val
  end
end

class AVLTree
  attr_reader :root
  def initialize
    @root = nil
  end

  def height(node)
    node ? node.height : 0
  end

  def right_rotate(node)
    new_root = node.left
    node2 = new_root.right

    new_root.right = node
    node.left = node2

    node.height = [height(node.right), height(node.left)].max + 1
    new_root.height = [height(new_root.right), height(new_root.left)].max + 1

    new_root
  end

  def left_rotate(node)
    new_root = node.right
    node2 = new_root.left

    new_root.left = node
    node.right = node2

    node.height = [height(node.right), height(node.left)].max + 1
    new_root.height = [height(new_root.right), height(new_root.left)].max + 1

    new_root
  end
  def insert_root_children(val, node)
    return Node.new(val) unless node

    if val <= node.val
      node.left = insert_root_children(val, node.left)
    else
      node.right = insert_root_children(val, node.right)
    end
    node.height = [height(node.right), height(node.left)].max + 1
         
    balance_tree_insertion(node, val)
  end

  def balance_tree_insertion(node, val)
    balance_factor = get_balance(node)
    if balance_factor < -1
      if val > node.right.val
        return left_rotate(node)
      elsif val < node.right.val
        node.right = right_rotate(node.right)
        return left_rotate(node)
      end
    elsif balance_factor > 1
      if val < node.left.val
        return right_rotate(node)
      elsif val > node.left.val
        node.left = left_rotate(node.left)
        return right_rotate(node)
      end
    end
    node
  end

  def insert(val)
    @root = insert_root_children(val, root)
  end

  def get_balance(node)
    node ? height(node.left) - height(node.right) : 0
  end

  def in_order(node = root)
    return [] unless node

    in_order(node.left).concat([node.val]).concat(in_order(node.right))
  end

  def min_node(node)
    return node unless node.left

    min_node(node.left)
  end

  def delete_min(node = root)
    return nil unless node

    return node.right unless node.left
      
    node.left = delete_min(node)

    node
  end
  def delete(val)
    @root = delete_root_children(root, val)
  end

  def delete_root_children(node, val)
    return node unless node

    if val > node.val
      node.right = delete_root_children(node.right, val)
    elsif val < node.val
      node.left = delete_root_children(node.left, val)
    else
      return node.left unless node.right
      return node.right unless node.left
      cur_node = node
      node = min_node(cur_node)

      node.left = cur_node.left
      node.right = delete_min(cur_node.right)
    end
    
    return node unless node

    balance_tree_deletion(node)
  end

  def balance_tree_deletion(node)
    node.height = [height(node.right), height(node.left)].max
    balance_factor = get_balance(node)
    if balance_factor > 1
      if get_balance(node.left) < 0
        node.left = left_rotate(node.left)
      end
      return right_rotate(node)

    elsif balance_factor < -1
      if get_balance(node.right) > 0
        node.right = right_rotate(node.right)
      end
      return left_rotate(node)
    end
    node
  end
end