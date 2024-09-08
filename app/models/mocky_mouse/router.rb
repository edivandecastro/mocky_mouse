module MockyMouse
  class Router
    METHODS = [:get, :post, :put, :patch, :delete, :options, :head].freeze

    REGISTERED_MOCKS = []

    class << self
      def register_mock(mock)
        REGISTERED_MOCKS << mock.id
        MockyMouse::ApplicationState.instance.update_token :mock
        REGISTERED_MOCKS.uniq!
      end

      def register_current_mocks
        REGISTERED_MOCKS << MockyMouse::Mock.pluck(:id)
        REGISTERED_MOCKS.flatten!
        REGISTERED_MOCKS.uniq!
      end

      def unregister_mock(mock)
        REGISTERED_MOCKS.delete mock.id
        MockyMouse::ApplicationState.instance.update_token :mock
      end

      def reset!
        REGISTERED_MOCKS.clear
        register_current_mocks
        reload_routes!
      end

      def load_mock_routes!
        mocks =  REGISTERED_MOCKS.map do |mock_id|
          MockyMouse::Mock.find mock_id
        end

        mocks = mocks.sort_by{ |mock| mock.mock_order }

        mocks.each do |mock|
          define_route mock
        end
      end

      def reload_routes!
        MockyMouse::Application.routes_reloader.reload!
      end

      protected

      def define_route(mock)
        return unless mock.active?

        MockyMouse::Application.routes.draw do
          self.send(:match, "#{mock.user_id}/#{mock.route_path}", to: 'mocky_mouse/mocks#serve_mock',
            defaults: { mocky_mouse_mock_id: mock.id }, via: mock.request_method)
        end
      end
    end
  end
end
