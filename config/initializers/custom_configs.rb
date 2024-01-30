# frozen_string_literal: true

module CustomConfigs
  class Application < Rails::Application
    # config.anti_fraud_rules = YAML.unsafe_load(
    #   ERB.new(File.read(Rails.root.join('config/anti_fraud_rules.yml').to_s)).result
    # )[Rails.env]
    config.anti_fraud_rules = config_for(:anti_fraud_rules)
  end
end
