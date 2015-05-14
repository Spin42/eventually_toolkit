require "sidekiq"

module EventuallyToolkit
  class DataWorker
    include Sidekiq::Worker

    def perform
      event_hashes   = fetch_data
      event_handler  = EventHandler.new
      event_handler.handle(event_hashes)
    end
  end
end
