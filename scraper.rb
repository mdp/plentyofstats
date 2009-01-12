require 'rubygems'
require 'cgi'
require 'open-uri'
require 'hpricot'


def url
  base = "http://www.plentyoffish.com/advancedsearch.aspx?"
  attributes = { :iama => 'm', 
              :seekinga => 'f', 
              :wantchildrem => nil, 
              :MinAge => 25, 
              :MaxAge => 25,
              :smoke => nil,
              :country => 1,
              :drugs => nil,
              :City => 30309,
              :miles => 5,
              :interests => nil,
              :state => nil,
              :height => nil,
              :heightb => nil,
              :religion => nil,
              :haschildren => nil,
              :drink => nil,
              :thnicity => nil,
              :viewtype => nil,
              :starsign => nil,
              :searchtype => nil,
              :body => nil,
              :smarts => nil,
              :income => nil,
              :cmdSearch => "Go Fishing"
              }
  attributes.merge!(YAML::load(File.open( 'options.yaml' ))['attributes'])
              
  opts = ""
  attributes.each_pair { |k,v|
    v ||= ""
    v = v.to_s
    opts << "#{k}=#{CGI.escape(v)}&"
  }
  base + opts.chop
end


open(url, "User-Agent" => "Yahoo",
    "Referer" => "http://www.google.com/") { |f|
    puts "Fetched document: #{f.base_uri}"
    puts "\\t Content Type: #{f.content_type}\\n"
    puts "\\t Charset: #{f.charset}\\n"
    puts "\\t Content-Encoding: #{f.content_encoding}\\n"
    puts "\\t Last Modified: #{f.last_modified}\\n\\n"
 
    # Save the response body
    @response = f.read
}

doc = Hpricot(@response)

results =  (doc/"/html/body/center/table[3]/tr/td").inner_html

p results =~ /Results \d+ to \d+ out of (\d+) results are shown below/
