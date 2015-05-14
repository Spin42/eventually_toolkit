module EventuallyToolkit
  class Railtie < Rails::Railtie
    railtie_name :eventually_toolkit

    config.to_prepare do
      EventuallyToolkit.init
    end

    rake_tasks do
      load("tasks/data_workers.rake")
      load("tasks/projectors.rake")
    end
  end
end
