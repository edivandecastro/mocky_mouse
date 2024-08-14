module MockyMouse
  class Synchronizer
    cattr_accessor :mock_synchronization_token

    def initialize(app)
      @app = app
    end

    def call(env)
      application_state = MockyMouse::ApplicationState.instance

      if MockyMouse::Synchronizer.mock_synchronization_token != application_state.mock_synchronization_token
        Rails.logger.info 'Mock synchronization token missmatch. Syncronizing...'
        MockyMouse::Router.reset!
        MockyMouse::Synchronizer.mock_synchronization_token = application_state.mock_synchronization_token
        Rails.logger.info 'Mock synchronization completed.'
      end

      @status, @headers, @response = @app.call(env)

      [@status, @headers, @response]
    end

    class << self
      def generate_token
        SecureRandom.uuid
      end
    end
  end
end
