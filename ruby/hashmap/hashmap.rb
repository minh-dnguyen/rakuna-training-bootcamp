class HashMap
  attr_reader :load_factor, :capacity

  def initialize(capacity = 16, load_factor = 0.75)
    @capacity = capacity
    @load_factor = load_factor
    @buckets = Array.new(@capacity) { [] }
    @length = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def set(key, value)
    index = hash(key) % @capacity
    bucket = @buckets[index]

    # If key exists, overwrite the value
    bucket.each do |pair|
      if pair[0] == key
        pair[1] = value
        return
      end
    end

    # If it's a new key, check if we need to resize before adding
    if @length >= @capacity * @load_factor
      resize
      # Recalculate index and bucket because capacity has doubled
      index = hash(key) % @capacity
      bucket = @buckets[index]
    end

    bucket << [key, value]
    @length += 1
  end

  def get(key)
    index = hash(key) % @capacity
    bucket = @buckets[index]

    bucket.each do |pair|
      return pair[1] if pair[0] == key
    end
    nil
  end

  def has?(key)
    index = hash(key) % @capacity
    @buckets[index].any? { |pair| pair[0] == key }
  end

  def remove(key)
    index = hash(key) % @capacity
    bucket = @buckets[index]

    bucket.each_with_index do |pair, i|
      if pair[0] == key
        deleted_value = pair[1]
        bucket.delete_at(i)
        @length -= 1
        return deleted_value
      end
    end
    nil
  end

  def length
    @length
  end

  def clear
    @buckets = Array.new(@capacity) { [] }
    @length = 0
  end

  def keys
    # flatten(1) merges the bucket arrays down one level, giving us an array of [key, value] pairs
    @buckets.flatten(1).map { |pair| pair[0] }
  end

  def values
    @buckets.flatten(1).map { |pair| pair[1] }
  end

  def entries
    @buckets.flatten(1)
  end

  private

  def resize
    old_entries = entries
    @capacity *= 2
    clear # Resets buckets and length, length will be rebuilt via set
    
    old_entries.each do |pair|
      set(pair[0], pair[1])
    end
  end
end

# --- EXTRA CREDIT ---
# A HashSet functions just like a HashMap but only stores unique keys.
class HashSet
  def initialize(capacity = 16, load_factor = 0.75)
    @capacity = capacity
    @load_factor = load_factor
    @buckets = Array.new(@capacity) { [] }
    @length = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code
  end

  def set(key)
    index = hash(key) % @capacity
    bucket = @buckets[index]

    return if bucket.include?(key) # Don't add if it already exists

    if @length >= @capacity * @load_factor
      resize
      index = hash(key) % @capacity
      bucket = @buckets[index]
    end

    bucket << key
    @length += 1
  end

  def get(key)
    has?(key) ? key : nil
  end

  def has?(key)
    index = hash(key) % @capacity
    @buckets[index].include?(key)
  end

  def remove(key)
    index = hash(key) % @capacity
    bucket = @buckets[index]

    if bucket.include?(key)
      bucket.delete(key)
      @length -= 1
      return key
    end
    nil
  end

  def length
    @length
  end

  def clear
    @buckets = Array.new(@capacity) { [] }
    @length = 0
  end

  def keys
    @buckets.flatten
  end

  def entries
    @buckets.flatten
  end

  private

  def resize
    old_keys = keys
    @capacity *= 2
    clear
    old_keys.each { |k| set(k) }
  end
end