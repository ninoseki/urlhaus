# urlhaus

[URLHaus](https://urlhaus.abuse.ch/) query API wrapper for Ruby.

## Installation

```bash
gem install urlhaus
```

## Usage

```ruby
require "urlhaus"

api = URLhaus::API.new

# Query URL information
api.url("http://sskymedia.com/VMYB-ht_JAQo-gi/INV/99401FORPO/20673114777/US/Outstanding-Invoices/")
# Query host information
api.host("vektorex.com")
# Query payload information
api.payload("12c8aec5766ac3e6f26f2505e2f4a8f2")
# Query tag information
api.tag("Retefe")
# Query signature information
api.signature("Gozi")
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
