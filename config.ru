require 'rubygems'
require 'bundler'
Bundler.require(:default)

require './config/application'

map "/api" do 
  run Application
end
