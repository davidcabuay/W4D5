class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    #key to reference value and index
    key = 0
    self.each_with_index do |ele, idx|
      key = ele * idx + key
    end
    key
  end
end

class String
  #char.ord where char is a single letter
  def hash
    key = 0
    self.each_char.with_index do |char, idx|
      key = char.ord * idx + key
    end
    key
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    count = 0
    key = 0
    self.each do |k,v|
      key = v.hash * k.hash + key + count
      count +=1
    end
    key
  end
end
