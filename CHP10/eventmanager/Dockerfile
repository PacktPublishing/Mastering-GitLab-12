FROM ruby:2
COPY . /var/www/ruby  
WORKDIR /var/www/ruby
RUN bundle install
CMD ["ruby","eventmanager.rb"]  
EXPOSE 5000/tcp
