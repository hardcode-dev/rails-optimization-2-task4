if Rails.env != "test"
  require 'prometheus_exporter/middleware'
  require 'prometheus_exporter/client'

  prometheus_client = PrometheusExporter::Client.new(host: 'localhost')
  PrometheusExporter::Client.default = prometheus_client

  # This reports stats per request like HTTP status and timings
  Rails.application.middleware.unshift PrometheusExporter::Middleware
end
