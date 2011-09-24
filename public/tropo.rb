require 'net/http'

text=$currentCall.initialText

say "ok, #{text} comming right up..."

http = Net::HTTP.new('screenhead.herokuapp.com')

http.post "/text" , {:text=> text }

if /launch/ =~ text
  http.post "/launch", {}
  say "oh snap, now you're really in trouble...."
end
