module MockyMouse
  class Project < ApplicationRecord
    belongs_to :user, class_name: 'User', foreign_key: 'user_id'
    has_many :mocks, inverse_of: :project
  end
end
