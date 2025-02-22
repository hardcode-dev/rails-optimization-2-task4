RailsPerformance.setup do |config|
  config.redis    = Redis.new(url: ENV["REDIS_URL"].presence || "redis://127.0.0.1:6379/0") # or Redis::Namespace.new("rails-performance", redis: Redis.new), see below in README
  config.duration = 4.hours

  config.debug    = false # currently not used>
  config.enabled  = true

  # configure Recent tab (time window and limit of requests)
  # config.recent_requests_time_window = 60.minutes
  # config.recent_requests_limit = nil # or 1000

  # configure Slow Requests tab (time window, limit of requests and threshold)
  # config.slow_requests_time_window = 4.hours # time window for slow requests
  # config.slow_requests_limit = 500 # number of max rows
  # config.slow_requests_threshold = 500 # number of ms

  # default path where to mount gem,
  # alternatively you can mount the RailsPerformance::Engine in your routes.rb
  config.mount_at = '/rails/performance'

  # protect your Performance Dashboard with HTTP BASIC password
  config.http_basic_authentication_enabled   = false
  config.http_basic_authentication_user_name = 'rails_performance'
  config.http_basic_authentication_password  = 'password12'

  # if you need an additional rules to check user permissions
  config.verify_access_proc = proc { |controller| true }
  # for example when you have `current_user`
  # config.verify_access_proc = proc { |controller| controller.current_user && controller.current_user.admin? }

  # You can ignore endpoints with Rails standard notation controller#action
  # config.ignored_endpoints = ['HomeController#contact']

  # You can ignore request paths by specifying the beginning of the path.
  # For example, all routes starting with '/admin' can be ignored:
  config.ignored_paths = ['/rails/performance', '/admin']

  # store custom data for the request
  # config.custom_data_proc = proc do |env|
  #   request = Rack::Request.new(env)
  #   {
  #     email: request.env['warden'].user&.email, # if you are using Devise for example
  #     user_agent: request.env['HTTP_USER_AGENT']
  #   }
  # end

  # config home button link
  config.home_link = '/'

  # To skip some Rake tasks from monitoring
  config.skipable_rake_tasks = ['webpacker:compile']

  # To monitor rake tasks performance, you need to include rake tasks
  # config.include_rake_tasks = false

  # To monitor custom events with `RailsPerformance.measure` block
  # config.include_custom_events = true

  # To monitor system resources (CPU, memory, disk)
  # to enabled add required gems (see README)
  # config.system_monitor_duration = 24.hours
end if defined?(RailsPerformance)
