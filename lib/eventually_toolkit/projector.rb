module EventuallyToolkit
  class Projector

    def initialize
      @event_bus      = EventBus.new
      @event_handlers = {}
      @logger         = EventuallyToolkit.logger
    end

    def start
      register_handlers
      @logger.debug "#{self.class.name} started for events: #{@event_handlers.keys}"
      loop do
        event_hash      = @event_bus.pop(self.class.name.underscore, true)
        event_handlers  = @event_handlers[event_hash["name"]]
        if event_handlers
          @logger.debug "#{self.class.name} process '#{event_hash["name"]}'."
          event = EventFactory.build_from_projector(event_hash)
          event_handlers.each do | event_handler |
            event_handler.call(event)
          end
        end
      end
    end

    def on(event_name, &block)
      @event_handlers[event_name] = [] unless @event_handlers[event_name]
      @event_handlers[event_name].push(block)
    end

    def self.event_bus_queue
      "#{self.name.underscore}_event_bus_queue"
    end
  end
end
