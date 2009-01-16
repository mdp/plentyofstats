require 'rubygems'
require 'cgi'
require 'open-uri'
require 'hpricot'
require 'db'

class PlentyOfStats
  
  attr_reader :opts
  
  def init(options)
    opts = options
  end
  
  def scrape
    @scrape = Scrape.create(:description =>  definition)
    
    opts = YAML::load(File.open( 'options.yaml' ))[definition]
    attributes = opts['attributes']
    (opts['range']['StartAge']..opts['range']['StartAge']).each { |i|
        doc = Hpricot(get(url(attributes.merge(:minage => i, :maxage => i))))
        result =  (doc/"/html/body/center/table[3]/tr/td").inner_html
        result =~ /Results \d+ to \d+ out of (\d+) results are shown below/
        @scrape.stats.build(:result => result, :age => i, :gender =>  )
      }

    }
  end

  def opts=(options)
    @opts = options['attributes'].merge(default_attributes)
  end
  
  def url
    attributes = ""
    opts.each_pair { |k,v|
      v ||= ""
      v = v.to_s
      attributes << "#{k}=#{CGI.escape(v)}&"
    }
    base + attributes.chop
  end
  
  def get
    @response
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
    @response
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

