require 'redis'
require 'open-uri'
require 'json'

uri = URI.parse(ENV["REDISTOGO_URL"])
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)


loop do
  key,text=REDIS.blpop("screenhead:text",5)
  puts text
  unless text.nil?
    json = JSON.load(open("https://ajax.googleapis.com/ajax/services/search/images?v=1.0&rsz=1&q=#{URI.escape(text)}"))
    img_url=json['responseData']['results'][0]['unescapedUrl']
    `open #{img_url}`
  end
  Kernel.sleep 1
end
