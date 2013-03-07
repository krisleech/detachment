require 'spec_helper'

describe Detachment do
  it 'subscribes to events' do

    class MyResponder
      include Detachment
      # subscribe :create_new_trip
    end

  end
end
