require "detachment/version"
require 'active_support/concern'

module Detachment
  extend ActiveSupport::Concern

  class Store
    def self.add(event, klass)
      @@data ||= {}
      @@data[event] ||= []
      @@data[event] << klass
    end

    def self.find(event)
      @@data ||= {}
      @@data[event]
    end

    def self.delete(event, klass)
      @@data ||= {}
      @@data[event] ||= []
      @@data[event].delete(klass)
    end

    def self.delete_all
      @@data = nil
    end
  end

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
