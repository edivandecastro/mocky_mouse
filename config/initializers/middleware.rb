Rails.application.config.middleware.insert_after Rails::Rack::Logger, MockyMouse::Synchronizer
