require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  #linked-list -> (hash_map for the rest) bucket - > array - > linked list - > node
  #in our bucket, instead of bucket[key.hash], bucket[proc.call(key)]
  #only 1 linked list. values all point to 1 hash map.a
  #keys are stored in linked list
  #each of those keys will point to the location on the hashmap (aka our bucket and bucket will check if node exists)
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map[key]
      node = @map[key]
      self.update_node!(node)
    else
      self.calc!(key)
    end
  #   hash_key = @prc.call(key)
  #   @store.each do |cache_node|
  #     cache_node_key = cache_node.val
  #     if cache_node_key == hash_key
  #       @map.bucket(hash.key).get(key)
  #     end
  #   end
  # end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key 
    val = @prc.call(key)
    node = @store.append(key,val)
    @map[key] = node
    self.eject! if self.count> @max
    val
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    node.remove
    @map[node.key]=@store.append(node.key, node.val)
    
    # node.prev.next =node.next
    # node.next.prev = node.prev
    # @tail.prev.next = node
    # node.prev = @tail.prev
    # node.next = @tail
    # @tail.prev = node
  end

  def eject!
    node = @store.first
    node.remove
    @map.delete(node.key)
    nil
  end
end
