require 'sinatra'
require 'yaml/store'

set :bind, '0.0.0.0'

get '/results' do
  @title = 'Attendees'
  @yaml = YAML.load_file('attendees.yml')
  @attendees = @yaml['attendees']
  erb :results
end

get '/:guid' do
  @guid = params[:guid]
  @yaml = YAML.load_file('attendees.yml')
  @attendees = @yaml['attendees']
  @attendees.each do |letter, _hash|
    if @attendees[letter]['guid'] == @guid
      @personname = @attendees[letter]['name']
    end
  end
  erb :index, :locals => {:guid => params[:guid]}
end

post '/register' do
  @title = 'Thanks for the information!'
  @presence  = params['presence']
  @person = params['person']
  @yaml = YAML.load_file('attendees.yml')
  @attendees = @yaml['attendees']
  @attendees.each do |letter, _hash|
    if @attendees[letter]['guid'] == @person
      @attendees[letter]['attending'] = @presence
    end
  end
 
  output = YAML.dump @yaml
  File.write("attendees.yml", output)

  erb :register
end

Choices = {
  'YES' => 'YES',
  'NO' => 'NO',
  'MAYBE' => 'MAYBE',
}
