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
    locations.each_value do |l|
      puts "Starting scrape of #{l}"
      self.attributes = {:City => l}
      2.times do |s|
        self.attributes = {:iama => 'm', :seekinga => 'f'} if s == 0
        self.attributes = {:iama => 'f', :seekinga => 'm'} if s == 1
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
          @scrape.stats.build(:result => results, :age => a, :gender => attributes[:seekinga], :zipcode => attributes[:City] ).save
        end
      end
    end
  end
  
  def attributes=(options)
    @attributes = @attributes.merge(options)
  end


  def fetch
    base = "http://www.plentyoffish.com/advancedsearch.aspx?"
    params = ""
    attributes.each_pair { |k,v|
      v ||= ""
      v = v.to_s
      params << "#{k}=#{CGI.escape(v)}&"
    }
    open(base + params.chop, "User-Agent" => "Yahoo", "Referer" => "http://www.google.com/").read
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
