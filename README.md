# OffTheChain

This is a small utility library meant to build up chained method calls seperately from the object that will originate the chain. Put another way, it's meant to define a series of method calls on an Enumerable style object without having the enumerable at the time of definition.

## Installation

Add this line to your application's Gemfile. The *Chain* class will be included in the gobal name space.

```ruby
gem 'off_the_chain', require: 'off_the_chain/import'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install off_the_chain

## Usage

Method chains can be created the same way you might use them with a normal chainable type:

```ruby
# Define a method chain
method_chain = Chain.zip([1,2,3].cycle)
    .map { |pair| pair.first * pair.last }
    .select { |num| num.even? }
    .reduce(10) { |memo,num| memo + (num * 2) }

# Sometime later
method_chain.apply(1..100000) # => The correct numerical answer
```

Chains can be combined as well to make composable operations.

```ruby
# Basic filter for dealing with records
basic_filter = Chain.reject(&:disabled?).select(&:valid?)

# Customer Emails
email_addresses = Chain.select(&:wants_email?).map(&:email)

# This will apply the chain left to right
good_emails = (basic_filter << email_addresses).reject(&:blank?)

good_emails = apply( customer_records ) # => array of emails
```

## Why?

The goal of this gem is to be able to define a series of calls before the subject of the chain is available and then share that defined operation with different components in the system.

I needed a sane way to pull scopes out of ActiveRecord models. I tried to use the solution provided by [Rectify](https://github.com/andypike/rectify#query-objects), but it didn't really jive with the way I want to write code. My general strategy is that I define individual scopes on my models and then combine them using chains that are injected as dependencies.

I've also used this for business transformations where I might have had to define a whole new class.

I'd recommend also checking out [transproc](https://github.com/solnic/transproc). I honestly think the transproc style of defining data transforms is better than what I have here, but it's tough to get team buy in on something so far deviated from vanilla ruby.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Justin Scott/off_the_chain.

