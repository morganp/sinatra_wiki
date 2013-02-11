# sinatra\_wiki

sinatra\_wiki is a minimal wiki, using Ruby and Sinatra.  
Now on [GitHub Pages][githubpages].

[githubpages]: http://morganp.github.com/sinatra_wiki 

## Usage

    $ git clone git://github.com/morganp/sinatra_wiki.git
    $ cd sinatra_wiki
    $ gem install bundler     # If not in your global gemset
    $ bundle install
    $ rake db:migrate_devel or rake db:migrate 
    $ ruby sinatra_wiki.rb

Then open a browser in http://0.0.0.0:4567/  
To create a page, just type the URL 

## Heroku

    $ heroku create

Heroku apps no longer come setup with a database. To try out this app you will have to at least setup a FREE dev database.

    $ heroku addons:add heroku-postgresql:dev
        Adding heroku-postgresql:dev on yourherokuapp... done, v14 (free)
        Attached as HEROKU_POSTGRESQL_BRONZE_URL

Make HEROKU_POSTGRESQL_BRONZE_URL available as DATABASE_URL

    $ heroku pg:promote HEROKU_POSTGRESQL_RED_URL
    Promoting HEROKU_POSTGRESQL_RED_URL to DATABASE_URL... done

Deploy App:

    $ git push heroku master

Run DB Migration:

    heroku run rake db:migrate

## License 

See the LICENSE file
