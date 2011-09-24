require "bundler/setup"
Bundler.require(:default)

configure do
  require 'redis'
  uri = URI.parse(ENV["REDISTOGO_URL"])
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end

get "/" do
  "text something to (443) 305-8151"
end

get "/launch" do
  #get whether there's a launch
  launch=REDIS.get("screenhead:launch")
  raise Sinatra::NotFound if launch.nil?
end

delete "/launch" do
  REDIS.del("screenhead:launch")
end

post "/launch" do
  REDIS.set("screenhead:launch","YEP")
end

post "/text" do
    text=params[:text]
    REDIS.rpush "screenhead:text", text
end

