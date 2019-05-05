require 'spec_helper'
require 'rack/test'
require_relative '../eventmanager'
 
RSpec.describe 'The EventManager App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "default page" do
    get '/'
    expect(last_response.body).to include("Welcome")
    expect(last_response).to be_ok
  end

  it "displays results" do 
    get '/results'
    expect(last_response.body).to include("Attendees")
    expect(last_response).to be_ok
  end

  it "register" do 
    get '/register'
    expect(last_response.body).to include("register")
    expect(last_response).to be_ok
  end

end