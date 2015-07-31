require 'singleton'

# Pool for managing expensive Stanford Core objects
class PipelinePool
  include Singleton
  MIN_POOL_SIZE = 1
  MAX_POOL_SIZE = 4

  def initialize
    @pool = Pool.new(MAX_POOL_SIZE)
    MIN_POOL_SIZE.times { @pool.add(Pipeline.new) }
  end

  def fetch
    @pool.fetch { Pipeline.new }
  end

  def method_missing(method, *args)
    @pool.send(method, *args)
  end
end
