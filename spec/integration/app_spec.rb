require "spec_helper"
require "rack/test"
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
























































































  context "GET /properties" do
    it 'returns all properties' do
      response = get("/properties")

      expect(response.status).to eq(200)
      #expect(response.body).to include('Amazing for the weekend')
      #expect(response.body).to include('Escape to a Romantic and Magical Hobbit Retreat')
    end

    it 'returns 404 Not Found' do
      response= get('/listing')

      expect(response.status).to eq(404)
      # expect(response.body).to eq(expected_response)
    end
  end
end

