class Marker < ActiveRecord::Base
  has_many :stops

  geocoded_by :address
  after_validation :geocode


  def self.next_stop(id)
    self.select('*, stops.departure_time').joins("JOIN stops on markers.id = stops.marker_id").where("stops.departure_time > LOCALTIME - INTERVAL '6 hours' and markers.id = ?", id).order("stops.departure_time ASC")
  end

  def self.closest(lat, long)
    self.select("*, ABS(((#{lat} - latitude) + ( #{long} - latitude))) as dist").order('dist').limit(10)
  end

end