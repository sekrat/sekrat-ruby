# Sekrat

Sekrat is an embedded key/value store for secrets. These secrets are stored in a Warehouse (Memory, Filesystem, Amazon S3, etc), and they are encrypted/decrypted with a Crypter (Passthrough, AES, etc).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sekrat'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sekrat

## Usage

The basic usage for Sekrat goes something like this:

```ruby
require 'sekrat'

# Create a secret manager to put and get secrets.
confidant = Sekrat.manager

# Create a secret
confidant.put("my sausages", "supersecretkey", "turned to gold")

# Retrieve that secret
confidant.get("my sausages", "supersecretkey")
```

In the above, we don't provide a warehouse or a crypter for the manager to use to do its thing, so the defaults (respectively, in-memory hash storage of plain text data) are used. An equivalent manager could be set up like so:

```ruby
require 'sekrat'
require 'sekrat/warehouse/memory'
require 'sekrat/crypter/passthrough'

confidant = Sekrat.manager(
  warehouse: Sekrat::Warehouse::Memory.new,
  crypter: Sekrat::Crypter::Passthrough.new
)
```

All that said, things don't really get interesting until you add in a Warehouse and a Crypter other than the defaults.

### Warehouses ###

A warehouse is any object that conforms  the `Sekrat::Warehouse::Base` API:

* `ids` returns an array of all known secret IDs in the warehouse
* `store(id, data)` stores the provided data indexed by the provided ID, raising an error if there are any issues (and specifically `Sekrat::StorageFailure` if there is a problem actually storing the secret)
* `retrieve(id)` retrieves and returns the ID-indexed data, raising an error if there are any issues (and specifically `Sekrat::NotFound` if the secret is not already stored in the warehouse)

To help a bit with Warehouse development, you can `include Sekrat::Warehouse::Base` in your implementation. It contains all of the methods in the Warehouse API, all of which raise `Sekrat::NotImplemented` until you override them.

The only warehouse included in the base gem is `Sekrat::Warehouse::Memory`, which stores secrets in an in-memory hash. That's only really useful in initial testing and development, so it would be a very good idea to either create your own warehouse or maybe peruse [Warehouse Implementations](https://github.com/sekrat/sekrat-ruby/wiki/Warehouse-Implementations).

### Crypters ###

A Crypter is any object that conforms to the `Sekrat::Crypter::Base` API:

* `encrypt(key, data)` encrypts the given data with the provided key and returns that encrypted data, raising an error if there are any issues (and specifically `Sekrat::EncryptFailure` if there is a problem encrypting the data)
* `decrypt(key, data)` decrypts the given data with the provided key and returns that decrypted data, raising an error if there are any issues (and specifically `Sekrat::DecryptFailure`)

To help a bit with Crypter development, you can `include Sekrat::Warehouse::Base` in your implementation. It contains all of the methods in the Crypter API, all of which raise `Sekrat::NotImplemented` until you override them.

The only crypter included in the base gem is `Sekrat::Warehouse::Passthrough`, which doesn't actually do anything at all ... its method just return the provided data. That's only really useful in initial testing and development, so it would be a very good idea to either create your own crypter or maybe peruse [Crypter Implementations](https://github.com/sekrat/sekrat-ruby/wiki/Crypter-Implementations).


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sekrat/sekrat. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Sekrat project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/sekrat/blob/master/CODE_OF_CONDUCT.md).
