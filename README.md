# Moromi::Error

[![Latest Version](https://img.shields.io/gem/v/moromi-error.svg)](http://rubygems.org/gems/moromi-error)
[![Circle CI](https://circleci.com/gh/moromi/moromi-error.svg?style=svg)](https://circleci.com/gh/moromi/moromi-error)

Error templates.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'moromi-error'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install moromi-error

## Usage

### Initializers

- initializers/moromi/error.rb

```ruby
Moromi::Error.configure do |config|
  config.debug = true
  config.store_url = 'https://itunes.apple.com/jp/app/idxxxxxxxxxx'
end
```

### for Controller

```ruby
class PagesController < ApplicationController
  include Moromi::Error::Renderer
  include Moromi::Error::Rescue
end
```

- `Moromi::Error::Renderer`

define render_xxx methods.

- `Moromi::Error::Rescue`

when raise Moromi::Error::Default or subclass, handle with `rescue_from`.

it's optional module.

### Copy Template

- jbuilder and erb

```ruby
bundle exec rails g moromi:error:views -e erb
```

- jbuilder and slim

```ruby
bundle exec rails g moromi:error:views -e slim
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/moromi/moromi-error.

