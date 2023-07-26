require "sinatra"
require "sinatra/reloader"
require "http"
require "json"


get("/") do
  @raw_data= HTTP.get("https://api.exchangerate.host/symbols")
  @parsed_data = JSON.parse(@raw_data)
  @symbols = @parsed_data.fetch("symbols").keys

  erb(:home)
end
