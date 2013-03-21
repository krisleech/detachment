module Detachment
  class Store
    def self.add(event, klass)
      @@data ||= {}
      @@data[event] ||= Set.new
      @@data[event] << klass
    end

    def self.find(event)
      @@data ||= {}
      @@data[event]
    end

    def self.delete(event, klass)
      @@data ||= {}
      @@data[event] ||= Set.new
      @@data[event].delete(klass)
    end

    def self.delete_all
      @@data = nil
    end
  end
end
