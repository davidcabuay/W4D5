require_relative 'p04_linked_list'

class HashMap
include Enumerable
attr_accessor :count, :store
  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    self.bucket(key).include?(key)
  end

  def set(key, val)
    if !self.include?(key) #key doesnt exist
      self.bucket(key).append(key,val)
      self.count += 1
    else
      self.bucket(key).update(key, val)
    end
    self.resize! if self.count > num_buckets
  end

  def get(key)
    if self.include?(key)
      return self.bucket(key).get(key)
    end
    nil
  end

  def delete(key)
    if self.include?(key)
      self.count -=1
    end
    self.bucket(key).remove(key)
  end

  def each
    @store.each do |ll|
      ll.each do |node|
        yield [node.key, node.val]
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    self.count = 0
    @store= Array.new(num_buckets*2){LinkedList.new}
    old_store.each {|old_ll| old_ll.each {|node| self.set(node.key, node.val)}} #each {|ele| self.set(ele)}
  end

  def bucket(key)
    self.store[key.hash%num_buckets]
    # optional but useful; return the bucket corresponding to `key`
  end
end
