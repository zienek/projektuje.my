require 'sinatra'
require 'sinatra/base'
require 'sinatra/assetpack'

class App < Sinatra::Base
  set :root, File.dirname(__FILE__) 

  register Sinatra::AssetPack

  assets {
    serve '/js',     from: 'public/javascripts'
    serve '/css',    from: 'public/stylesheets'
    serve '/images', from: 'public/images'    

    serve '/', from: 'public'
  
    master_css = [
      "/bootstrap/css/bootstrap.css", 
      "/stylesheets/orbit-1.2.3.css",
      "/stylesheets/font-awesome.min.css",
      "/stylesheets/style.css",
      # "/stylesheets/demo-style.css"
    ]

    css :master, '/stylesheets/master.css', master_css
    
    master_js = [
      "/javascripts/html5shiv.js",
      "/javascripts/jquery-2.0.3.min.js",
      "/bootstrap/js/bootstrap.min.js", 
      "/javascripts/jquery.orbit-1.2.3.min.js",
      "/javascripts/respond.min.js"
    ]
    
    js :master, '/javascripts/master.js', master_js
    
    
    js_compression  :uglify 
    css_compression :sass
    
    
  }

  set :haml, layout: :_layout # Default layout.

  get '/' do 
    get_locale == 'pl' ? haml(:index_pl, layout: :_layout_pl) : haml(:index, layout: :_layout) 
  end
  
  get '/contact/?' do 
    get_locale == 'pl' ? haml(:contact_pl, layout: :_layout_pl) : haml(:contact, layout: :_layout) 
  end
  
  
  helpers do
    def get_locale
      # Pulls the browser's language
      @env["HTTP_ACCEPT_LANGUAGE"][0,2]
    end
  end
end



  