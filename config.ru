require 'rubygems'
require 'bundler'
Bundler.require(:default)

require './config/application'

map "/api" do 
  run Application
end

map "/" do
  use Rack::Static, 
    :urls => ["/images", "/js", "/css"],
    :root => File.join('frontend', '_public'), 
    :index => 'index.html'
  
  run lambda {|*|}
end

map "/uploads" do
  use Rack::Static,
    :urls => [""],
    :root => File.join('public', 'uploads')
  
  run lambda {|*|}
end