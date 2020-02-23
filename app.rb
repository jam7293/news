require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "68302eac872084d657a8fbff6a33d39b"


# do the heavy lifting, use Global Hub lat/long
forecast = ForecastIO.forecast(42.0574063,-87.6722787).to_hash

# pp = pretty print
# use instead of `puts` to make reading a hash a lot easier
# e.g. `pp forecast`
# pp forecast

current_temperature = forecast["currently"]["temperature"]
conditions = forecast["currently"]["summary"]
puts "In Evanston, it is currently #{current_temperature} and #{conditions}"
puts forecast["daily"]["data"]
high_temperature = forecast["daily"]["data"][0]["temperatureHigh"]
puts high_temperature
puts forecast["daily"]["data"][1]["temperatureHigh"]
puts forecast["daily"]["data"][2]["temperatureHigh"]

for day in forecast["daily"]["data"]
    puts "A high temperature of #{day["temperatureHigh"]} and #{day["summary"]}"
end

get "/" do
  view "geocode"
end

get "/map" do
  results = Geocoder.search(params["q"])
  lat_long = results.first.coordinates
  "#{lat_long[0]}" "#{lat_long[1]}"
end

get "/news" do
    view "ask"
end

get "/news" do
      results = Geocoder.search(params["q"])
      lat_long = results.first.coordinates
      "#{lat_long[0]}" "#{lat_long[1]}"
       url = "https://newsapi.org/v2/top-headlines?country=us&apikey=3a20f00aca104a0683a7d2a229e8f8fe"
       news = HTTparty.get(url).parsed_response.to_hash
       pp news
end