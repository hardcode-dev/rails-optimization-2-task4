# rubocop:disable Metrics/BlockLength

Rails.application.configure do
  config.webpacker.check_yarn_integrity = false
  config.cache_classes = true
  config.eager_load = true

  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  config.read_encrypted_secrets = true

  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?
  config.public_file_server.headers = {
    "Cache-Control" => "public, s-maxage=2592000, max-age=86400"
  }

  config.assets.js_compressor = Uglifier.new(harmony: true)

  config.assets.compile = true
  config.assets.digest = true

  # config.cache_store = :memory_store
  # config.public_file_server.headers = {
  #   "Cache-Control" => "public, max-age=172800"
  # }

  config.log_level = :debug
  config.log_tags = [:request_id]

  config.action_mailer.perform_caching = false

  # config.action_mailer.raise_delivery_errors = false

  config.i18n.fallbacks = [I18n.default_locale]

  # config.active_support.deprecation = :notify

  config.log_formatter = ::Logger::Formatter.new
  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end

  # send_logs_to_timber = ENV["SEND_LOGS_TO_TIMBER"] || "false"
  # log_device = send_logs_to_timber == "true" ? Timber::LogDevices::HTTP.new(ENV["TIMBER"]) : STDOUT
  # logger = Timber::Logger.new(log_device)
  # logger.level = config.log_level
  # config.logger = ActiveSupport::TaggedLogging.new(logger)
  #
  # config.active_record.dump_schema_after_migration = false

  config.app_domain = "localhost:3000"

  # config.action_mailer.delivery_method = :smtp
  # config.action_mailer.perform_deliveries = true
  # config.action_mailer.default_url_options = { host: config.app_domain }
  # config.action_mailer.smtp_settings = {
  #   address: "smtp.gmail.com",
  #   port: "587",
  #   enable_starttls_auto: true,
  #   user_name: '<%= ENV["DEVELOPMENT_EMAIL_USERNAME"] %>',
  #   password: '<%= ENV["DEVELOPMENT_EMAIL_PASSWORD"] %>',
  #   authentication: :plain,
  #   domain: "localhost:3000"
  # }
  # config.action_mailer.preview_path = "#{Rails.root}/spec/mailers/previews"
end

# rubocop:enable Metrics/BlockLength
