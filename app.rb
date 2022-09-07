require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/database_connection'
require_relative 'lib/property_repository'
require_relative 'lib/users_repository'
require_relative 'lib/property'
require_relative 'lib/users'

class Application < Sinatra::Base
    # This allows the app code to refresh
    # without having to restart the server.
    configure :development do
        register Sinatra::Reloader
        also_reload 'lib/property_repository'
        also_reload 'lib/users_repository'
    end

      get '/' do
          return erb(:index)
      end


# We need to give the database name to the method `connect`.
  DatabaseConnection.connect('makersbnb_test')




















































































  get '/properties' do 
    repo = PropertyRepository.new
    @properties = repo.all
    return erb(:properties)
  end
end
