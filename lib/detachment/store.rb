require 'singleton'

module Detachment
  class Store
    include Singleton

    def initialize
      @data ||= {}
    end

    def add(event, klass, method_map = {})
      @data[event] ||= Set.new
      @data[event] << { :klass => klass }.merge(method_map)
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
  end
end
