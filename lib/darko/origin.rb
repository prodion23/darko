module Darko::Origin
  attr_accessor :darko_initialized_at
  def initialize *args
    @darko_initialized_at = caller(1,50) # skip 0 because that is here
    super *args
  end
end

class Object
  prepend Darko::Origin
end