require "redis"
require "json"

module EventuallyToolkit
  class EventBus

    def initialize
      @redis  = Redis.new(:url => EventuallyToolkit.config.redis_url)
      @queues = {}
      EventuallyToolkit.config.projectors.each do | projector_name |
        class_name = "#{projector_name}_projector"
        @queues[class_name] = class_name.camelize.constantize.event_bus_queue
      end
    end

    def push(data)
      @queues.values.each do | queue |
        @redis.rpush(queue, data.to_json)
      end
    end

    def pop(projector_class_name, block=false)
      queue = @queues[projector_class_name]
      if block
        event_hash = @redis.blpop(queue)[1]
      else
        event_hash = @redis.lpop(queue)[1]
      end
      JSON.parse(event_hash)
    end

  end
end
