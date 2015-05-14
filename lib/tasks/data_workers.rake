namespace :data_workers do

  def perform(data_worker_name)
    "#{data_worker_name}_data_worker".camelize.constantize.send(:perform_async)
    EventuallyToolkit.logger.info("Perform " + data_worker_name.to_s + " asynchronously...")
  end

  task :list => :environment do
    EventuallyToolkit.config.data_workers.each do | data_worker_name |
      info = {
        "name"  => data_worker_name,
        "class" => "#{data_worker_name}_data_worker".camelize.constantize
      }
      ap info
    end
  end

  task :perform, [ :data_worker_name ] => :environment do | task, args |
    data_worker_name = args.data_worker_name

    if data_worker_name == "all"
      EventuallyToolkit.config.data_workers.each do | _data_worker_name |
        perform(_data_worker_name)
      end
    else
      perform(data_worker_name)
    end
  end

end
