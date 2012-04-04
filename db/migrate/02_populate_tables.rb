
class Page < ActiveRecord::Base
end


class PopulateTables < ActiveRecord::Migration
  def self.up
    @page = Page.create(
      :url => 'readme',
      :body => %{# sinatra_wiki

sinatra_wiki is the minimal expression of a wiki.

It uses Sinatra.rb, and is being built as a learning experiment.

## Required gems
* rubygems
* sinatra
* erb
* rdiscount
* thin
* activesupport
* sinatra-cache


## Usage

    $ gem install bundler
    $ bundle install
    $ rake db:migrate_devel or rake db:migrate  
    $ ruby sinatra_wiki.rb

Then open a browser in http://0.0.0.0:4567/

To create a page, just type the URL for it (the URL is the command line, baby :)}
    )


    @page.save
  end

  def self.down
    Page.delete_all
  end
end
