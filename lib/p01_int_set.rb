class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)

  end

  def insert(num)
    if is_valid?(num)
      @store[num] = true 
    else
      raise "Out of bounds"
    end
  end

  def remove(num)
    if is_valid?(num)
      @store[num] = false 
    end
  end

  def include?(num)
    @store[num]
  end

  def store
    @store
  end

  private

  def is_valid?(num)
    if num >=0 && num < @store.length
      return true
    else 
      return false
    end
  end

  def validate!(num)
  end
end


class IntSet
  attr_reader :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    self.store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store
  attr_writer :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !self.include?(num)
      self[num] << num
      self.count += 1
    end
    self.resize! if self.count > num_buckets
  end

  def remove(num)
    if self.include?(num)
      self.count-=1
    end
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    self.store[num%num_buckets]
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
