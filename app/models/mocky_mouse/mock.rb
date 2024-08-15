class MockyMouse::Mock < ApplicationRecord
  SCRIPT_TYPE_EMBEDDED_RUBY = 'embedded_ruby'
  SCRIPT_TYPE_JS = 'js'
  SCRIPT_TYPE_STATIC = 'static'

  has_many :headers, dependent: :destroy, inverse_of: :mock
  accepts_nested_attributes_for :headers, allow_destroy: true, reject_if: :all_blank

  validates :status, presence: true
  validates :request_method, presence: true
  validates :content_type, presence: true
  validates :route_path, presence: true, route: true
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :body_type, inclusion: { in: [SCRIPT_TYPE_STATIC,
                                        SCRIPT_TYPE_EMBEDDED_RUBY,
                                        SCRIPT_TYPE_JS],
                                    allow_blank: true },
                      presence: { unless: :body_content_blank? }
  validates :body_content, presence: { unless: :body_type_blank? }
  validates :script_type, inclusion: { in: [SCRIPT_TYPE_STATIC,
                                            SCRIPT_TYPE_EMBEDDED_RUBY,
                                            SCRIPT_TYPE_JS],
                                     allow_blank: true },
                          presence: { unless: :script_blank? }
  validates :script, presence: { unless: -> { script_type.blank? } }
  validates :active, presence: { if: -> { active_nil? } }

  before_save :set_order
  after_save :register
  after_destroy :unregister

  default_scope { order(mock_order: :asc) }

  def dynamic?
    body_type != SCRIPT_TYPE_STATIC
  end

  def activate!
    self.update_attribute(:active, true)
  end

  def deactivate!
    self.update_attribute(:active, false)
  end

  #########
  protected
  #########

  def set_order
    self.mock_order ||= (MockyMouse::Mock.maximum(:mock_order) || 0) + 1
  end

  def register
    MockyMouse::Router.register_mock self
  end

  def unregister
    MockyMouse::Router.unregister_mock self
  end

  #########
  private
  #########

  def body_content_blank?
    body_content.blank?
  end

  def body_type_blank?
    body_type.blank?
  end

  def script_blank?
    script.blank?
  end

  def self.script_type_blank?
    script_type.blank?
  end

  def active_nil?
    active.nil?
  end
end
