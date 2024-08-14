class MockyMouse::Header < ApplicationRecord
  belongs_to :mock, inverse_of: :headers

  validates :name, presence: true
  validates :value, presence: true
  validates :mock, presence: true
end
