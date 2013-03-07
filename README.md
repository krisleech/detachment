# Detachment

A transparent Sub / Pub broker for sending messages between objects

## Installation

    gem 'detachment'

## Usage

```ruby
class MyResponder
  include Detachment
  subscribe(:foo)

  def foo(name)
    raise 'This Happened'
  end
end

class MyPublisher
  include Detachment

  def execute
    publish(:foo, 'bar')
  end
end

MyPublisher.new.execute # => RuntimeError 'This Happened'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
