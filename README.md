# Courier

1. Thread-safe, without resorting to thread-safe class attributes.
2. Convert data into OpenStruct objects, even the nested resources also work well.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'courier'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install courier

## Usage

```ruby
# Create session
cs = Courier::Session.new(shopify_domain, token: shopify_token)
# or private app
cs = Courier::Session.new(shopify_domain, api_key: 'secret', password: 'secret')
```

```ruby
# Find resource
order  = cs.find(:orders, 2983176710)
# return a OpenStruct object
order.class # OpenStruct
order.email # buyer@email.com
order.customer.default_address.class # Recursive OpenStruct object
order.customer.default_address.country_code
# get list without params
orders = cs.find(:orders)
orders.count # default 50
# get list with params
orders = cs.find(:orders, nil, params: {limit: 5})
orders.count # 5
```

```ruby
# Update resource
order = cs.update(:orders, 2983176710, {id: 2983176710, tags: 'new-tag, tag-again'})
order.tags # 'new-tag, tag-again'
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/raecoo/courier. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

