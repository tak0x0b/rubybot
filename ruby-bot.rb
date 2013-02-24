require 'mechanize'
require 'twitter'

#Get N255 from yahoo finance
agent = Mechanize.new
agent.get('http://stocks.finance.yahoo.co.jp/stocks/detail/?code=998407.O')
n225 = agent.page.at("td[@class='stoksPrice']").inner_text.delete(",")

#Get Twitter key and token from file
apikey = ARGF.readlines.map!{|key| key.chomp}

#Set Twitter key and token
Twitter.configure do |cnf|
  cnf.consumer_key = apikey[0]
  cnf.consumer_secret = apikey[1]
  cnf.oauth_token = apikey[2]
  cnf.oauth_token_secret = apikey[3]
end

#Tweet N225
Twitter.update("N225: " + n225)
