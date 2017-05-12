require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PairBnB
  class Application < Rails::Application
  	config.sass.load_paths << File.expand_path('../../lib/assets/stylesheets/')
    config.sass.load_paths << File.expand_path('../../vendor/assets/stylesheets/')
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
    config.assets.initialize_on_precompile = false
  end
end
