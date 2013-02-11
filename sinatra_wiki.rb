#Sinatra Wiki

%w(rubygems sinatra/base erb maruku thin yaml digest/sha1 haml active_record sass).each do |lib|
  require lib
end

Dir["lib/*.rb"].each do |lib|
  require_relative lib
end


module SinatraWiki
  VERSION = '0.3.1'
    
  ## Load Models
  Dir[File.dirname(__FILE__) + '/lib/models/*.rb'].each {|file| require file }


  class App < Sinatra::Base
    use Rack::MethodOverride
    set :public_folder, "public"
    ## Allow white space control in erb templates using -%>
    set :erb, :trim => '-'


    configure do
      @config = YAML::load(File.read('config.yml')).to_hash.each do |k,v|
        set k, v
      end
    end


    helpers do
      def protected!
        unless authorized?
          response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
          throw(:halt, [401, "Not authorized\n"])
        end
      end

      def authorized?
        # Auth turned on in config.yml
        if settings.use_auth
          @auth ||=  Rack::Auth::Basic::Request.new(request.env)
          @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == [settings.username, settings.password]
        else 
          true
        end
      end
    end



    configure :development do
      set 'analytics', false

      ActiveRecord::Base.establish_connection(
        :adapter   => 'sqlite3',
        :pool      => 25,
        :database  => './db/devel.db'
      )
    end

    configure :production do
      set 'analytics', true
      ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"])
    end

    before do
      content_type 'text/html', :charset => 'utf-8'
    end

    get '/' do
      @pages = Page.all 
      erb :home
    end

    get '/base.css' do
      sass :'stylesheets/base'
    end

    get '/:slug' do
      @page = Page.find_by_url(params[:slug])
      redirect "/#{params[:slug]}/edit" if @page.nil?
      erb :page
    end

    get '/:slug/edit' do
      protected!
      @page = Page.find_by_url( params[:slug] )
      @new  = @page.nil? 
      @page = Page.new( :url => params[:slug] ) if @new

      erb :edit
    end

    post '/:slug/?' do
      protected!
      nice_title = Slugalizer.slugalize(params[:title])
      @page      = Page.create(
        :url  => nice_title,
        :body => params[:body]
      )
      redirect "/" + @page.url
    end

    put '/:slug/?' do
      protected!
      nice_title = Slugalizer.slugalize(params[:title])
      @page      = Page.find_by_url( params[:slug] )
      @page.url  = nice_title
      @page.body = params[:body]
      @page.save
      redirect "/" + @page.url
    end

  end
end

if $0 == __FILE__
  SinatraWiki::App.run!
end

