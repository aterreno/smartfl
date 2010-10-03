# encoding: UTF-8
# Encoding.default_internal = Encoding.default_external = 'UTF-8'

require "bundler/setup"
require "sinatra"
require "haml"
require "sass"
require "sass/plugin/rack"
require "mechanize"
require File.expand_path('tfl')

configure do
  set :haml, { :attr_wrapper => '"', :format => :html5 }
  set :root, File.dirname(__FILE__)
  use Sass::Plugin::Rack
end

configure :production do
  enable :raise_errors
end

get "/" do
  haml :index
end

post "/timetable" do
  Tfl.find_results(params[:from].gsub(/\s/, ''), params[:to].gsub(/\s/, ''))
end
