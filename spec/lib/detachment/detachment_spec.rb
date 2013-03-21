require 'spec_helper'
require_relative '../../../lib/detachment'

describe Detachment do
  before { Detachment::Store.instance.delete_all }

  describe 'subscribing' do
    it 'does not add same class more than one to same event' do
      class MyResponder
        include Detachment
        subscribe(:foo)
      end

      class MyResponder
        include Detachment
        subscribe(:foo)
      end

      Detachment::Store.instance.find(:foo).size.should == 1
    end
  end

  it 'publishes events' do

    class MyResponder
      include Detachment
      subscribe(:foo)

      def foo(name)
        name.upcase
      end
    end

    class MyPublisher
      include Detachment

      def execute
        publish(:foo, 'bar')
      end
    end

    responder = MyResponder.new
    responder.should_receive(:foo).with('bar')
    MyResponder.should_receive(:new).and_return(responder)

    MyPublisher.new.execute
  end
end
