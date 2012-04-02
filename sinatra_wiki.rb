#Sinatra Wiki

%w(rubygems sinatra erb rdiscount thin yaml digest/sha1 haml).each do |lib|
  require lib
end

Dir["lib/*.rb"].each do |lib|
  require_relative lib
end

configure do
  @config = YAML::load(File.read('config.yml')).to_hash.each do |k,v|
    set k, v
  end
end
Dir[File.dirname(__FILE__) + '/lib/models/*.rb'].each {|file| require file }

configure :development do
  %x(rake expire_cache)
  set :cache_enabled, false
end

before do
  content_type 'text/html', :charset => 'utf-8'
  @page = Page.new("home") # Default page
end

get '/' do
  @pages = Dir["public/**/*.txt"]
  #cache erb :home
  erb :home
end

get '/:slug' do
  @page = Page.new(params[:slug])
  if @page.is_new
    redirect "/#{@page.name}/edit"
  else
    erb :page
  end
end

get '/:slug/edit' do
  auth
  @page = Page.new(params[:slug])
  erb :edit
end
    configure :development do
      # %x(rake expire_cache)
      #set :cache_enabled, false
      set 'analytics', false
      set 'thing', ['one', 'two']
      set 'hash', {:value => 'data'}

      ActiveRecord::Base.establish_connection(
        :adapter   => 'sqlite3',
        :database  => './db/devel.db'
      )
    end

post '/:slug/edit' do
  auth
  nice_title = Slugalizer.slugalize(params[:title])
  @page = Page.new(nice_title)
  @page.content = params[:body]
  #expire_cache "/"
  #expire_cache "/#{nice_title}"
  redirect "/#{nice_title}"
    configure :production do
      set 'analytics', true
      db = ENV["DATABASE_URL"]
      if db.match(/postgres:\/\/(.*):(.*)@(.*)\/(.*)/) 
        username = $1
        password = $2
        hostname = $3
        database = $4

        ActiveRecord::Base.establish_connection(
          :adapter  => 'postgresql',
          :host     => hostname,
          :username => username,
          :password => password,
          :database => database
        )
      end
    end
    before do
      content_type 'text/html', :charset => 'utf-8'
      #@page = Page.new("home") # Default page
    end

    get '/' do
      @pages = Page.all 
      erb :home
    end

    get '/:slug' do
      @page = Page.find_by_url(params[:slug])
      if @page.nil?
        redirect "/#{params[:slug]}/edit"
      else
        erb :page
      end

    end

    get '/:slug/edit' do
      auth
      @page = Page.find_by_url( params[:slug] )
      if @page.nil?
        @page = Page.new(
          :url => params[:slug]
        )
      end

      erb :edit
    end

    post '/:slug/edit' do
      auth
      nice_title = Slugalizer.slugalize(params[:title])
      @page = Page.create(
       :url  => nice_title,
       :body => params[:body]
      )
      redirect "/#{nice_title}"
    end
end

get '/base.css' do
  #cache sass :base
  sass :base
end
