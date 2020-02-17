# Darko

## 28:06:42:12 

Darko helps you debug.  A great use case for Darko is if you want to know *exactly* when a piece of data is mutated.  Darko allows you to watch objects, spy on their attributes, drop `irb` or `pry` upon mutations, & really help you get to the root of what is going on.

Just like Frank without the bunny suit.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'darko'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install darko

## Usage

This is a super simple example with watching an instance of class `Foo`

```ruby
require 'darko'
# Some class with something you aren't sure why is changing
class Foo
  attr_accessor :data
  def initialize data
    @data = data
  end
end

an_object = Foo.new('data')
frank = Darko::Watcher.new(an_object, :@data)
frank.enable! # this will start the object spy

foo.data += 'yep gonna add this here - this might be occuring in some background thread, some meta programmed method, something magical and mystical that you can\'t easily put a breakpoint on'
# Darko will output a stack trace showing you exactly WHERE the mutation is occuring, allowing you to figure out the why more easily
frank.disable! # this will quit spying and put everything back to normal :)
```

Darko also works on instance variables of a class
```ruby
require 'darko'

frank = Darko::Watcher.new(Foo, :@class_instance_variable)
frank.enable! # this will start the object spy

Foo.class_instance_variable += 'more_data'
# Darko will output a stack trace showing you exactly WHERE the mutation is occuring, allowing you to figure out the why more easily
frank.disable! # this will quit spying and put everything back to normal :)
```

& on class variables
```ruby
class Foo
  @@class_var = []
  def self.class_var
    @@class_var
  end
end
frank = Darko::Watcher.new(Foo, :@@class_var)
frank.enable! # this will start the object spy

Foo.class_var += 'more_data'
# Darko will output a stack trace showing you exactly WHERE the mutation is occuring, allowing you to figure out the why more easily
frank.disable!
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/prodion23/darko. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/prodion23/darko/blob/master/CODE_OF_CONDUCT.md).

All PR's are welcome :) - before merging you must provide test coverage of the feature.  If you plan to do any extreme rewrites or redesigns please open an issue so we can talk about it.  


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct
TL;DR - Be nice to everyone

Everyone interacting in the Darko project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/Darko/blob/master/CODE_OF_CONDUCT.md).
