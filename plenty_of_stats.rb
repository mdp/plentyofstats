require 'rubygems'
require 'cgi'
require 'open-uri'
require 'hpricot'
require 'db'

class PlentyOfStats

  attr_reader :opts, :attributes, :locations, :range

  def initialize(name, options)
    @opts = options
    @attributes = self.default_attributes.merge(options[:attributes])
    @locations= options[:locations]
    @range= options[:range]
    @scrape = Scrape.create(:description =>  name)
  end

  def scrape
    locations.each_pair do |k, v|
      puts "Starting scrape of #{k}"
      self.attributes = {:City => v[:zipcode], :miles => v[:radius]}
      2.times do |s|
        self.attributes = s == 0 ? {:iama => 'm', :seekinga => 'f'} : {:iama => 'f', :seekinga => 'm'}
        puts "\tSearching for #{attributes[:seekinga]}"
        (range[:StartAge]..range[:EndAge]).each do |a|
          self.attributes = {:MinAge => a, :MaxAge => a}
          doc = Hpricot(self.fetch)
          results =  (doc/"/html/body/center/table[3]/tr/td").inner_html
          if results.match(/Results \d+ to \d+ out of (\d+) results are shown below/)
            results = $1
          elsif results.match(/Only (\d+) results are shown below/)
            results = $1
          else
            raise Hell
          end
          puts "\tAge #{a} - #{results} results"
          @scrape.stats.build(:result => results, :age => a, :gender => attributes[:seekinga], 
                              :zipcode => attributes[:City], :radius => attributes[:miles],
                              :url => url).save
        end
      end
    end
  end
  
  def attributes=(options)
    @attributes = @attributes.merge(options)
  end


  def fetch
    open(url, "User-Agent" => "Yahoo", "Referer" => "http://www.google.com/").read
  end
  
  def url
    base = "http://www.plentyoffish.com/advancedsearch.aspx?"
    params = ""
    attributes.each_pair { |k,v|
      v ||= ""
      v = v.to_s
      params << "#{k}=#{CGI.escape(v)}&"
    }
    base + params.chop
  end


  def default_attributes
    { :iama => 'm',
      :seekinga => 'f',
      :wantchildrem => nil,
      :MinAge => 18,
      :MaxAge => 19,
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
  end
end
