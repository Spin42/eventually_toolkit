module EventuallyToolkit
  class EventHandler

    def initialize
      @event_bus = EventBus.new
    end

    def handle(event_hashes)
      event_hashes.each do |event_hash|
        persist_on_event_store(event_hash)
        publish_on_event_bus(event_hash)
      end
    end

    def persist_on_event_store(event_hash)
      event = EventFactory.build_from_event_bus(event_hash)
      event.save!
    end

    def publish_on_event_bus(event_hash)
      @event_bus.push(event_hash)
    end
  end
end
