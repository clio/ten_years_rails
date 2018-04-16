# Ten Years of Rails Upgrades

This is a companion to the "Ten Years of Rails Upgrades" conference talk from RailsConf 2018. You'll found various utilities that we use at Clio to help us prepare for and complete Rails upgrades.

These scripts are still early days and may not work in every environment or app.

I wouldn't recommend adding this to your Gemfile long-term. Rather, try out the scripts and use them as a point of reference. Feel free to tweak them to better fit your environment.

## Usage

### `bundle_report`

Learn about your Gemfile and see what needs updating.

```
# Show all out-of-date gems
bundle_report outdated
# Show five oldest, out-of-date gems
bundle_report outdated | head -n 5
# Show gems that don't work with Rails 5.2.0
bundle_report compatibility --rails-version=5.2.0
bundle_report --help
```

### Deprecation tracking

If you're using RSpec, add this snippet to `rails_helper.rb` or `spec_helper.rb` (whichever loads Rails).

```ruby
RSpec.configure do |config|
  # Tracker deprecation messages in each file
  if ENV["DEPRECATION_TRACKER"]
    DeprecationTracker.track_rspec(
      config,
      shitlist_path: "spec/support/deprecation_warning.shitlist.json",
      mode: ENV["DEPRECATION_TRACKER"],
      transform_message: -> (message) { message.gsub("#{Rails.root}/", "") }
    )
  end
end
```

We don't use MiniTest, so there isn't a prebuilt config for it but I suspect it's pretty similar to `DeprecationTracker.track_rspec`.

Once you have that, you can start using deprecation tracking in your tests:

```
# Run your tests and save the deprecations to the shitlist
DEPRECATION_TRACKER=save rspec
# Run your tests and raise an error when the deprecations change
DEPRECATION_TRACKER=compare rspec
```

#### `deprecations` command

Once you have stored your deprecations, you can use `deprecations` to display common warnings, run specs, or update the shitlist file.

```
deprecations info
deprecations info --pattern "ActiveRecord::Base"
deprecations run
deprecations --help # For more options and examples
```

Right now, the path to the shitlist is hardcoded so make sure you store yours at `spec/support/deprecations.shitlist.json`.


### Dual-boot Rails next

This command helps you dual-boot your application.

```bash
next --init         # Create Gemfile.next
vim Gemfile         # Tweak your dependencies conditionally using `next?`
next bundle install # Install new gems
next rails s        # Start server using Gemfile.next
```
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ten_years_rails_conf_2018'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ten_years_rails_conf_2018

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ten_years_rails_conf_2018. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TenYearsRailsConf2018 project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ten_years_rails_conf_2018/blob/master/CODE_OF_CONDUCT.md).
