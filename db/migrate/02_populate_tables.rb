
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
* maruku
* thin
* haml
* sass
* activerecord
* activesupport
* sinatra-cache


## Usage

     $ git clone git://github.com/morganp/sinatra_wiki.git
    $ cd sinatra_wiki
    $ gem install bundler     # If not in your global gemset
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
