require "sinatra"
require "sinatra/reloader"
require "http"
require "json"


def currencies
  raw_data= HTTP.get("https://api.exchangerate.host/symbols")
  parsed_data = JSON.parse(raw_data)
  currency_keys = parsed_data.fetch("symbols").keys

  return currency_keys

end

get("/") do
  @symbols = currencies
  
  erb(:home)
end

get("/:symbol") do
  @symbol = params.fetch("symbol") 

  @symbols = currencies

  erb(:second_step)
end

get("/:symbol/:conversion") do
  @symbol = params.fetch("symbol")
  @conversion = params.fetch("conversion")

  raw_conversion = HTTP.get("https://api.exchangerate.host/convert?from=#{@symbol}&to=#{@conversion}")
  parsed_conversion = JSON.parse(raw_conversion)
  @rate = parsed_conversion.fetch("result")

  erb(:third_step)
end
