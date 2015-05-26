namespace :projectors do

  def start(projector_name)
    klass = "#{projector_name}_projector".camelize.constantize
    pid   = fork do
      klass.new.start
    end
    EventuallyToolkit.logger.info("Start " + projector_name.to_s + "...")
    pid
  end

  task :list => :environment do
    EventuallyToolkit.config.projectors.each do | projector_name |
      klass = "#{projector_name}_projector".camelize.constantize
      info  =  {
        "name"            => projector_name,
        "class"           => klass,
        "event_bus_queue" => klass.event_bus_queue
      }
      ap info
    end
  end

  task :start, [ :projector_name ] => :environment do | task, args |
    projector_name = args.projector_name
    pids           = []

    if projector_name.nil?
      EventuallyToolkit.config.projectors.each do | _projector_name |
        pids.push(start(_projector_name))
      end
    else
      pids.push(start(projector_name))
    end

    Signal.trap("SIGINT") do
      EventuallyToolkit.logger.info("Terminating...")
      pids.each do |pid|
        EventuallyToolkit.logger.info("Sending sig term to #{pid}.")
        Process.kill("TERM", pid)
      end
    end
    Process.wait
  end

end
