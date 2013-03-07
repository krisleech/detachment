require "detachment/version"
require 'activesupport/concern'

module Detachment
  extend ActiveSupport::Concern

  module ClassMethods

    def subscribe(event)
      @@subscribes[event] ||= []
      @@subscribes[event] << self
    end

    
  end
end
