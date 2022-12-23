
class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    self.prev.next = self.next
    self.next.prev = self.prev
    self.prev = nil
    self.next = nil
  end
end

class LinkedList
include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    if @head.next == @tail #&& @tail.prev == @head
      return true
    end
    false
  end

  def get(key)
    self.each do |node|
      return node.val if node.key == key
    end
    nil
  end

  def include?(key)
    self.each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    #head->1->2->3->tail
    #head->1->2->3->4->tail
    x = Node.new(key, val)
    self.last.next = x
    x.prev = self.last
    @tail.prev = x
    x.next = @tail
    return x
  end

  def update(key, val)
    self.each do |node|
    if node.key == key
      node.val = val 
      return node
    end
    end
    nil
  end

  def remove(key)
    self.each do |node|
      if node.key==key
        node.remove
        return nil
      end
    end
    nil
  end

  def each
    pointer = @head.next
    until pointer == @tail
      yield pointer 
      pointer = pointer.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
