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




get "/" do
  view "geocode"
end

get "/news" do
  results = Geocoder.search(params["q"])
  lat_long = results.first.coordinates
  @location = results.first.city
  "#{lat_long[0]}" "#{lat_long[1]}"

forecast = ForecastIO.forecast(42.0574063,-87.6722787).to_hash
@forecast=forecast
@current_temperature = @forecast["currently"]["temperature"]
@conditions = @forecast["currently"]["summary"]


  url = "http://newsapi.org/v2/top-headlines?country=us&apikey=3a20f00aca104a0683a7d2a229e8f8fe"
  @news = HTTParty.get(url).parsed_response.to_hash
  view "news"
end
