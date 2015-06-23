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

The third is a sub-url for internal links.q

Method : Localize

example : OmniScrape.Localize("https://en.wikipedia.org/wiki/List_of_massively_multiplayer_online_role-playing_games", 1, "https://en.wikipedia.org")

This method takes three parameters the first should be the url to start at.  

The second parameter is the depth to crawl.  ***Warning: crawling grows at an INSANE rate.  

The third is a sub-url for internal links.

description: Localize will follow every link from the page provided and scrape the html from those pages, storing it as html files in subdirectories. 

The pages are linked to other local pages.  NOTE: Removed duplication :) 

Method : Localize_CSS

example:OmniScrape.Localize_CSS("https://en.wikipedia.org/wiki/List_of_massively_multiplayer_online_role-playing_games", 1, "https://en.wikipedia.org", "div table.wikitable")

This method takes four parameters the first should be the url to start at.  

The second parameter is the depth to crawl.  ***Warning: crawling may grow at an INSANE rate.  

The third is a sub-url for internal links.

The fourth is a css selector for what parts of all pages you want to take the links for.

description:  Localize_CSS offers the same service that Localize provides while at the same time giving you the option to limit the result set using a css selector.

Method : Localize_IN

example : OmniScrape.Localize_IN("https://en.wikipedia.org/wiki/List_of_massively_multiplayer_online_role-playing_games", 1, "https://en.wikipedia.org")

This will perform the same actions as Localize, but only for internal links

Method : Localize_EX

example : OmniScrape.Localize_EX("https://en.wikipedia.org/wiki/List_of_massively_multiplayer_online_role-playing_games", 1, "https://en.wikipedia.org")

This will perform the same actions as Localize, but only for external links

Method : Localize_IN_CSS

example : OmniScrape.Localize_IN_CSS("https://en.wikipedia.org/wiki/List_of_massively_multiplayer_online_role-playing_games", 1, "https://en.wikipedia.org", "div table.wikitable")

This will perform the same actions as Localize_CSS, but only for internal links

Method : Localize_EX_CSS

example : OmniScrape.Localize_EX_CSS("https://en.wikipedia.org/wiki/List_of_massively_multiplayer_online_role-playing_games", 1, "https://en.wikipedia.org", "div table.wikitable")  NOTE: There are no external links in the wikitable! 

This will perform the same actions as Localize_CSS, but only for external links. 

## Contributing

1. Fork it ( https://github.com/bmaynard1991/omni-scrape )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
