# StreamCarrierwaveFile


... PROJECT NOT READY YET, STILL IN PROGRESS...

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stream_carrierwave_file'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stream_carrierwave_file

## Usage

```ruby
class MyLocalFileStorageUploader < CarrierWave::Uploader::Base
  storage :file

  # .... your configuration

  # #stream_fallback is different than #default_url because
  # configuration want to stream some "localy stored file" 
  # all the time, including the fallback image
  def stream_fallback
    Rails.root.join('app', 'assets', 'images', 'stream',
"fallback.png"
  end

 # ...
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/stream_carrierwave_file/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
