if (Rails.env.development? || Rails.env.local_production?) && ENV["RACK_TIMEOUT_WAIT_TIMEOUT"].nil?
  ENV["RACK_TIMEOUT_WAIT_TIMEOUT"] = "100000"
  ENV["RACK_TIMEOUT_SERVICE_TIMEOUT"] = "100000"
end

Rack::Timeout.unregister_state_change_observer(:logger) if (Rails.env.development? || Rails.env.local_production?)
Rack::Timeout::Logger.disable
