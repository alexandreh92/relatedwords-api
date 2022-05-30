# frozen_string_literal: true

class BaseService
  include Callable

  # rubocop:disable Style/RedundantInitialize
  def initialize(opts = {}); end
  # rubocop:enable Style/RedundantInitialize
end
