module EventuallyToolkit
  class Configuration
    include ActiveSupport::Configurable
    config_accessor :redis_url
    config_accessor :projectors
    config_accessor :data_workers
  end
end
