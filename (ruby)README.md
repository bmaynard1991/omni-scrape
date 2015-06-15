# OmniScrape

This gem is an all-purpose web crawler and scraper in the works.  

## Installation

Add these lines to your application's Gemfile:

```ruby
gem 'omni_scrape'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omni_scrape

## Usage
Add the lines :   require 'omni_scrape' and include OmniScrape to your script file.

Method : CrawlScrape  Note: this method is currently on a back burner. 

example : OmniScrape.CrawlScrape("http://en.wikipedia.org/wiki/List_of_massively_multiplayer_online_role-playing_games", 0, "http://en.wikipedia.org")

This method takes three parameters the first should be the url to start at.  

The second parameter is currently unimplemented but will be the depth to crawl. (just pass it 1) 

The third is a sub-url for internal links.

Method : Localize

example : OmniScrape.Localize("http://en.wikipedia.org/wiki/List_of_massively_multiplayer_online_role-playing_games", 1, "http://en.wikipedia.org")

This method takes three parameters the first should be the url to start at.  

The second parameter is the depth to crawl.  ***Warning: crawling grows at an INSANE rate.  

The third is a sub-url for internal links.

Method : FLocalize

This is the recursive method called by Localize and shouldn't be used directly.  :)

description: Localize will follow every link from the page provided and scrape the html from those pages, storing it as html files in subdirectories. 

The pages are linked to other local pages.  Currently there is a lot of duplication in this regard.  Note: Working on eliminating the duplication.  

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/omni_scrape/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
