require 'singleton'

module Detachment
  class Store
    include Singleton

    def initialize
      @data = {}
    end

    def add(event, klass, method_map = {})
      @data[event] ||= Set.new
      @data[event] << Subscription.new(klass, method_map)
    end

    def find(event)
      @data[event]
    end

    def delete(event, klass)
      return if @data[event].nil?
      @data[event].delete(klass)
    end

    def delete_all
      @@data = nil
    end

    class Subscription < Struct.new(:klass, :method_map); end
  end
end
