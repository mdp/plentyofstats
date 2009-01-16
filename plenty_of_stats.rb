require 'rubygems'
require 'cgi'
require 'open-uri'
require 'hpricot'
require 'db'

class PlentyOfStats

  attr_reader :opts

  def init(name, options)
    opts = options
    @scrape = Scrape.create(:description =>  name)
  end

  def scrape
    @opts['locations'].each_value do |l|
      p "Starting scrape of #{l}"
      2.times do |s|
        sex = {:iama => 'm', :seekinga => 'f'} if s == 0
        sex = {:iama => 'f', :seekinga => 'm'} if s == 1
        p "\tSearching for #{sex[:seekinga]}"
        (opts['range']['StartAge']..opts['range']['StartAge']).each do |a|
          p "\tSS #{sex[:seekinga]}"
          doc = Hpricot(get(url(attributes.merge(:minage => a, :maxage => a))))
          result =  (doc/"/html/body/center/table[3]/tr/td").inner_html
          result =~ /Results \d+ to \d+ out of (\d+) results are shown below/
          @scrape.stats.build(:result => result, :age => a, :gender => sex[:seekinga] ).save
        end
      end
    end
  end

  def opts=(options)
    @opts = default_attributes.merge(options['attributes'])
  end

  def url
    attributes = ""
    @opts.each_pair { |k,v|
      v ||= ""
      v = v.to_s
      attributes << "#{k}=#{CGI.escape(v)}&"
    }
    base + attributes.chop
  end

  def get
    open(url, "User-Agent" => "Yahoo", "Referer" => "http://www.google.com/").read
  end

  private

  def default_attributes
    { :iama => 'm',
      :seekinga => 'f',
      :wantchildrem => nil,
      :MinAge => minage,
      :MaxAge => maxage,
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
