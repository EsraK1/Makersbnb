require "spec_helper"
require "rack/test"
require "users_repository"
require_relative '../../app.rb'



def reset_property_table
  seed_sql = File.read('spec/seeds/properties_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end


describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET to /" do
    it "returns 200 OK with the right content" do
      # Send a GET request to /
      # and returns a response object we can test.
      response = get("/")

      # Assert the response status code and body.
      expect(response.status).to eq(200)
      expect(response.body).to include("Register")
      expect(response.body).to include("Sign in")
      expect(response.body).to include("View properties")
    end
  end

  before(:each) do
    reset_property_table
  end
  after(:each) do
    reset_property_table
  end

  context "GET /register" do
    it "displays registration page" do
      response = get("/register")

      expect(response.status).to eq(200)
      expect(response.body).to include("<form method='POST' action='/register'>")
      expect(response.body).to include("<input type='text' name='username'/>")
      expect(response.body).to include("<input type='text' name='email_address'/>")
      expect(response.body).to include("<input type='password' name='password'/>")
    end
  end

  context "POST /register" do
    it "creates a new user" do
      response = post("/register",
      username:"alex",
      email_address:"alex@gmail.com",
      password:"xela")

      expect(response.status).to eq(200)
      expect(response.body).to include("<h1>You have successfully registered!</h1>")
      response = get("/register")
    end

    it "checks if user is created" do
      response = post("/register",
        username:"alex",
        email_address:"alex@gmail.com",
        password:"xela")

        repo = UserRepository.new
        last_input = repo.all.last

        expect(last_input.username).to eq("alex")
        expect(last_input.id).to eq(3)
    end
  end

  context "#login check /login route" do 
    it 'check to see if login route valid' do 
      response = get("/login")

      expect(response.status).to eq(200)
      expect(response.body).to include("<label>Email address</label>")
      response = get("/login")
    end
  end

  context '#post login' do 
    it "successfully signs in user and redirect to success page" do 
      response = post("/login",
        email_address:"JackJones@gmail.com",
        password:"SkyBlue123")

        expect(response.status).to eq(200)
        expect(response.body).to include("<h1>You have logged in!</h1>")
    end

    it "sends user to unsuccessful page when account does not exist" do 
      response = post("/login",
      email_address:"Jack@gmail.com",
      password:"Sky123")

      expect(response.status).to eq(200)
      expect(response.body).to include("Account does not exist")
    end

    it "sends user to unsuccessful page when invalid password" do 
      response = post("/login",
      email_address:"JackJones@gmail.com",
      password:"Sky123")

      expect(response.status).to eq(200)
      expect(response.body).to include("Incorrect password")
    end
  end


  context "GET /properties" do
    it 'returns all properties' do
      response = get("/properties")
      expect(response.status).to eq(200)
      expect(response.body).to include('Semi detached 2 bedroom house')
      expect(response.body).to include('Tiny home')
    end

    it 'returns 404 Not Found' do
      response= get('/listing')
      expect(response.status).to eq(404)
    end
  end

  context "When calling GET /properties/:id and providing an ID number" do
    it '#returns a specific property' do
      get("/properties/1")
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include('Amazing for the weekend')
      get("/properties/2")
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include('Escape to a Romantic and Magical Hobbit Retreat')
    end
  end

  context "When calling GET /properties/new to add a new property" do
    it '#returns 200 and shows a form to take the data input' do
      get("/properties/new")
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include ('<form method="POST" action="/property">')
      expect(last_response.body).to include ('<h1>Add your new property on the market</h1>')
    end
  end

  context "When calling POST /property it stores the information in a new object" do
    it '#stores the information input' do
      post('/property', title: 'Palacio Real', description: 'Pasa una noche inolvidable con JuanCa', price_per_night: 10000)
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include ('Palacio Real')
      expect(last_response.body).to include ('Pasa una noche inolvidable con JuanCa')
      expect(last_response.body).to include ('10000')
    end
    it '#adds it to the list of properties' do
      post('/property', title: 'Palacio Real', description: 'Pasa una noche inolvidable con JuanCa', price_per_night: 10000)
      propertycheck = PropertyRepository.new.all[-1]
      expect(propertycheck.title).to eq ('Palacio Real')
      expect(propertycheck.description).to eq ('Pasa una noche inolvidable con JuanCa')
      expect(propertycheck.price_per_night).to eq (10000)
    end
  end
end

