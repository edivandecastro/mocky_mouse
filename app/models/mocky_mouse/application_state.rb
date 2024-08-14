module MockyMouse
  # The application state
  class ApplicationState < ApplicationRecord
    default_scope { order(id: :desc) }

    validates :singleton_guard, inclusion: { in: [0] }
    validates :mock_synchronization_token, presence: true

    def update_token(type)
      case type
      when :mock
        self.mock_synchronization_token = MockyMouse::Synchronizer.generate_token
        save
      end
    end

    class << self
      # @return [ApplicationState] the one and only application state
      def instance
        MockyMouse::ApplicationState.first ||
          MockyMouse::ApplicationState.create(singleton_guard: 0,
                                              mock_synchronization_token: MockyMouse::Synchronizer.generate_token)
      end
    end
  end
end
