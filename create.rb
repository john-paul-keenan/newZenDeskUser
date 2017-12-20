require 'net/http'
require 'uri'
require 'json'

puts "What is the new User's Email Address?"
newUserEmail = gets.strip
puts "Thanks! what is the user's first and last name?"
firstAndLastName = gets.strip

uri = URI.parse("https://mashape.zendesk.com/api/v2/users.json")
request = Net::HTTP::Post.new(uri)
request.basic_auth("<yourZDUserName>", "<yourZDPassword>")
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

# response.code
# response.body
