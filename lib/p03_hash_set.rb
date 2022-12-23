class HashSet
  attr_reader :count, :store
  attr_writer :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if !self.include?(key)
      self[key.hash] << key
      self.count += 1
    end
    self.resize! if self.count > num_buckets
  end

  def include?(key)
    self[key.hash].include?(key)
  end

  def remove(key)
    if self.include?(key)
      self.count-=1
    end
    self[key.hash].delete(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    self.store[num.hash%num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    self.count = 0
    @store= Array.new(num_buckets*2){Array.new()}
    old_store.flatten.each {|ele| self.insert(ele)}
  end
end
