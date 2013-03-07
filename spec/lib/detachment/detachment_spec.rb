require 'spec_helper'
require_relative '../../../lib/detachment'

describe Detachment do
  before { Detachment::Store.delete_all }

  it 'subscribes to events' do

    class MyResponder
      include Detachment
      subscribe(:foo)
    end

    Detachment::Store.find(:foo).should == [MyResponder]
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
