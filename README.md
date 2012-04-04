# sinatra\_wiki

sinatra\_wiki is a minimal wiki, using Ruby and Sinatra.  
Now on [GitHub Pages][githubpages].

[githubpages]: http://morganp.heroku.com/sinatra_wiki 

## Usage

    $ git clone git://github.com/morganp/sinatra_wiki.git
    $ cd sinatra_wiki
    $ gem install bundler     # If not in your global gemset
    $ bundle install
    $ rake db:migrate_devel or rake db:migrate 
    $ ruby sinatra_wiki.rb

Then open a browser in http://0.0.0.0:4567/  
To create a page, just type the URL 

## License 

See the LICENSE file
