require 'net/http'
require 'json'
require 'io/console'


puts "What is your Zen Desk Username (most likley your @konghq.com email address)"
zdUserName = gets.strip
puts "What is your Zen Desk password?"
zdPassword= STDIN.noecho(&:gets).chomp

puts "You are about to create a new end user in Zen Desk. This user wil have access to 
the Enterprise Only Documentation.\n
What is the new User's Email Address?"
newUserEmail = gets.strip
puts "Thanks! what is the user's first and last name?"
firstAndLastName = gets.strip

uri = URI.parse("https://mashape.zendesk.com/api/v2/users.json")
request = Net::HTTP::Post.new(uri)
request.basic_auth(zdUserName, zdPassword)
request.content_type = "application/json"
request.body = JSON.dump({
  "user" => {
    "name" => firstAndLastName,
    "email" => newUserEmail,
    "tags" => "portaluser"
  }
})

req_options = {
  use_ssl: uri.scheme == "https",
}

response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(request)
end

 response.code
 response.body
