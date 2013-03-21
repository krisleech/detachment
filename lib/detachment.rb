require "detachment/version"
require "detachment/store"
require 'active_support/concern'

module Detachment
  extend ActiveSupport::Concern

  private

  def publish(event, *args)
    Store.find(event).each { |subscriber| subscriber.new.send(event, *args) }
  end

  module ClassMethods
    def subscribe(event)
      Store.add(event, self)
    end
  end
end
