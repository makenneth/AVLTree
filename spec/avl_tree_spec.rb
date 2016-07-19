require 'rspec'
require 'avl_tree'

describe "AVL Tree" do
  let(:tree) { AVLTree.new }
  let(:roooot) { tree.root }
  before(:each) do
    tree.insert(20)
    tree.insert(10)
    tree.insert(30)
    tree.insert(5)
  end
  context "#height" do
    it "should return the right height of the tree" do
      expect(tree.height(roooot.left)).to eq(2)
      expect(tree.height(roooot.right)).to eq(1)
    end
  end

  context "#get_balance" do
    it "should return the degree of balance of the tree" do
      expect(tree.get_balance(roooot)).to eq(1)
    end
  end

  context "#in_order" do
    it "should return an array of numbers in order" do
      expect(tree.in_order).to eq([5, 10, 20, 30])
    end
  end

  context "#right_rotate" do
    it "should rotate correctly" do
      new_tree = AVLTree.new
      allow(new_tree).to receive(:root).and_return(Node.new(10))
      new_tree.root.left = Node.new(5)
      new_tree.root.left.left = Node.new(2)

      new_root = new_tree.right_rotate(new_tree.root)

      expect(new_root.val).to eq(5)
      expect(new_root.left.val).to eq(2)
      expect(new_root.right.val).to eq(10)
    end
  end

  context "#left_rotate" do
    it "should rotate correctly" do
      new_tree = AVLTree.new
      allow(new_tree).to receive(:root).and_return(Node.new(10))
      new_tree.root.right = Node.new(15)
      new_tree.root.right.right = Node.new(20)

      new_root = new_tree.left_rotate(new_tree.root)

      expect(new_root.val).to eq(15)
      expect(new_root.left.val).to eq(10)
      expect(new_root.right.val).to eq(20)
    end
  end

  context "#min_node" do
    it "should return the node with the minimum value" do
      expect(tree.min_node(roooot).val).to eq(5)
    end
  end
  context "#insert" do
    it "should balance the tree with node insertions" do
      tree.insert(2)
      expect(roooot.val).to eq(20)
      expect(roooot.right.val).to eq(30)
      expect(roooot.left.val).to eq(5)
      expect(roooot.left.left.val).to eq(2)
      expect(roooot.left.right.val).to eq(10)
      tree.insert(40)
      tree.insert(50)
      expect(roooot.right.val).to eq(40)
      expect(roooot.right.left.val).to eq(30)
      expect(roooot.right.right.val).to eq(50)
    end 
  end 

  context "#delete" do
    it "should be able to delete a node" do
      tree.delete(5)
      expect(tree.in_order).to eq([10, 20, 30])
    end

    it "should balance the tree in the process" do
      tree.delete(30)
      expect(roooot.val).to eq(10)
      expect(roooot.left.val).to eq(5)
      expect(roooot.right.val).to eq(20)
    end
  end
end