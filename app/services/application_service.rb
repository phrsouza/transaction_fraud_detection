# frozen_string_literal: true

class ApplicationService
  def self.call(**kargs, &)
    new(**kargs, &).call
  end

  def initialize
    raise 'Method not implemented'
  end

  def call
    raise 'Method not implemented'
  end
end
