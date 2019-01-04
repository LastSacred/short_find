# short_find

Allow a user to find things by typing just enough letters and/or numbers to make it unique. The user can enter a string of letters. Ignoring case, spaces, and special characters, if there is only one match, short_find will return the item that starts with those characters. If no item is matched, or if more than one item is matched it will give an error and allow the user to try again.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'short_find'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install short_find

## Methods

### ShortFind.object(objects, attr=:name)
Takes in an array of objects, and an object attribute as a symbol (defaulting to :name).
When called, takes input from the command line and uses it to find and return the object with the attribute that starts with the inputted characters.

### ShortFind.in_array(array)
Takes in an array strings, or objects of a type that can be converted to a string.
When called, takes input from the command line and uses it to find and return the element that starts with the inputted characters.

### ShortFind.in_hash(hash, by=:value)
Takes in a hash and a by parameter (:key or :value, defaulting to :value)
When called, takes input from the command line and uses it to find and return the element (key and value) with the key or value (specified with the by argument) that starts with the inputted characters.

## Options

### ShortFind.use_back(boolean)
Defaults to false. When set to true, any short_find method will return nil when "back" is entered in the command line.

### ShortFind.use_exit(boolean)
Defaults to false. When set to true, any short_find method will exit the program when "exit" is entered in the command line.

### ShortFind.outs(boolean)
Sets both use_back and use_exit

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/LastSacred/short_find. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ShortFind project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/LastSacred/short_find/blob/master/CODE_OF_CONDUCT.md).
