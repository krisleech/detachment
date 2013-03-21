require "detachment/version"
require "detachment/store"
require 'active_support/concern'

module Detachment
  extend ActiveSupport::Concern

  private

  def publish(event, *args)
    Store.instance.find(event).each do |subscription|
      klass = subscription.klass
      method = subscription.method_map.fetch(event) { event }
      klass.new.send(method, *args)
    end
  end

  module ClassMethods
    def subscribe(event, method_map = {})
      Store.instance.add(event, self, method_map)
    end
  end
end
