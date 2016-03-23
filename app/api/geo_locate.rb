require 'httparty'

class GeoLoc

  attr_reader :crds
  def initialize(ip)
    @url = 'http://ip-api.com/json/'
    @ip = ip
  end

  def get_hash
    @location = HTTParty.get(@url + @ip)
  end

  def coord
    @crds = {}
    @crds[:lat] = @location["lat"]
    @crds[:long] = @location["lon"]
  end

  def run
    get_hash
    coord
    @crds
  end
end

# g = GeoLoc.new('73.78.33.1')
# puts g.run