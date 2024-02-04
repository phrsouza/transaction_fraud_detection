# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = 'https://fe3d5b76e0ae408dd60b23aa6d0aab1e@o4506686246944768.ingest.sentry.io/4506686247927808'
  config.breadcrumbs_logger = %i[active_support_logger http_logger]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |_context|
    true
  end
end
