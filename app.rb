require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/database_connection'
require_relative 'lib/property_repository'
require_relative 'lib/users_repository'
require_relative 'lib/property.rb'

class Application < Sinatra::Base
    # This allows the app code to refresh
    # without having to restart the server.
    configure :development do
        register Sinatra::Reloader
        also_reload 'lib/property_repository'
        also_reload 'lib/users_repository'
    end



# We need to give the database name to the method `connect`.
  DatabaseConnection.connect('makersbnb_test')




















































































  get '/properties' do 
    repo = PropertyRepository.new
    @properties = repo.all
    # return erb(:properties)

    p "=============="
    p @properties.all

    # p "=============="
    # p @properties

    # p "=============="

    # p @properties[1].title 
    # p "=============="
    # @properties.each do |property|
    #   property.title
    # end
  end
end