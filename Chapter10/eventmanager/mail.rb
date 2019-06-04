require 'net/smtp'
require 'mail'
require 'yaml'

mail_server = ''
application_server = 'localhost'
mail_sender = 'Organizer@joustie.nl'
@yaml = YAML.load_file('attendees.yml')
@attendees = @yaml['attendees']
@attendees.each do |letter, _hash|

message = <<MESSAGE_END
<p>Hi!</p>

<p>I am organizing an event!</p> 

<p>You are welcome at the venue from 20.30!</p>

<p>Please let us know if you will attend  <a href="http://#{application_server}:4567/#{@attendees[letter]['guid']}">here!<a/></p>

<p>With kind regards<br/>
The organizer</p>
 

MESSAGE_END

mailto = "#{@attendees[letter]['name']} <#{@attendees[letter]['email']}>"
  Mail.deliver do
    to mailto
    delivery_method :smtp, address: mail_server, port: 25
    from mail_sender
    subject 'Invitation to event'
  
    text_part do
      body ''
    end
  
    html_part do
      content_type 'text/html; charset=UTF-8'
      body message
    end

  end

end
