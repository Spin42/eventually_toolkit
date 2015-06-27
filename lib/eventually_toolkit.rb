require "eventually_toolkit/version"
require "eventually_toolkit/logger"
require "eventually_toolkit/configuration"
require "eventually_toolkit/data_worker"
require "eventually_toolkit/event_bus"
require "eventually_toolkit/event_handler"
require "eventually_toolkit/event_factory"
require "eventually_toolkit/projector"
require "eventually_toolkit/railtie"

module EventuallyToolkit

  def self.configure(&block)
    yield @configuration ||= EventuallyToolkit::Configuration.new
  end

  def self.config
    @configuration
  end

  def self.logger
    @logger
  end

  def self.init
    @logger ||= @configuration.logger || EventuallyToolkit::Logger.new
  end

  configure do |config|
    config.redis_url    = "redis://localhost:6379/1"
    config.projectors   = []
    config.data_workers = []
    config.logger       = nil
  end
end

