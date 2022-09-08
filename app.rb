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
        enable :sessions #This enables the cookie session
    end

    #Home page
    get '/' do
        return erb(:index)
    end


    # We need to give the database name to the method `connect`
    DatabaseConnection.connect('makersbnb_test')

    #Register Page
    get '/register' do
        return erb(:'registration/register_page')
    end

    #Register a new user
    post '/register' do
        repo = UserRepository.new
        user = User.new

        user.username = params[:username]
        user.email_address = params[:email_address]
        user.password = params[:password]

        repo.create(user)

        return erb(:"registration/registration_successful")
    end

    #Login Page
    get '/login' do
      if session[:user]==nil
        return erb(:'login/login')
      end
    repo = PropertyRepository.new
    @properties = repo.all
    return erb(:'properties/properties')
    end

    #Login as a User
    post '/login' do
      repo = UserRepository.new

      email_address = params[:email_address]
      password = params[:password]
      user = repo.sign_in(email_address, password)
      if user == nil
        session[:fail_message] = "Account does not exist"
        return erb(:'login/login_unsuccessful')

      elsif user == false
        session[:fail_message] = "Incorrect password"
        return erb(:'login/login_unsuccessful')
      end

      #This is storing a User object into the session cookie, from the User login
      session[:user] = user

      return erb(:'login/login_successful')
    end















































    #Properties Listed on a webpage
    get '/properties' do
      repo = PropertyRepository.new
      @properties = repo.all
      return erb(:'properties/properties')
    end

    #Add a property
    get '/properties/new' do
      return erb(:'properties/new_property')
    end

    #Find properties by ID
    get '/properties/:id' do
      @find_properties = PropertyRepository.new.find(params[:id])
      return erb(:'properties/property_info')
    end

    #Adds a new property and takes you to its listing
    post '/property' do
      repo = PropertyRepository.new
      new_property = Property.new
      new_property.title = params[:title]
      new_property.description = params[:description]
      new_property.price_per_night = params[:price_per_night]
      new_property.start_date = params[:start_date]
      new_property.end_date = params[:end_date]
      #adding user_id to a new listing from session
      new_property.user_id = session[:user].id
      repo.create(new_property)
      @find_properties = repo.find(repo.all[-1].id)
      return erb(:'properties/property_info')
    end
  end

