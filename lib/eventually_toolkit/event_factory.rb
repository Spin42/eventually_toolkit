module EventuallyToolkit
  class EventFactory

    def self.build_from_projector(params)
      build(params)
    end

    def self.build_from_event_bus(params)
      build(params)
    end

    def self.build(params)
      event = Event.new
      params.each do | attribute, value |
        if attribute == "created_at"
          value = value.to_datetime
        end
        event[attribute] = value if event.attributes.include?(attribute)
      end
      event
    end
  end
end
