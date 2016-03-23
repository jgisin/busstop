# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


def get_stop(marker_id)
  stop_times = File.open("public/google_transit_Apr16_Runboard/stop_times.txt")
  time = stop_times.readlines

  time.each do |line|
    data = line.split(',')
    if data[3].to_i == marker_id
      Stop.create(marker_id: data[3], arrival_time: data[1], departure_time: data[2])
    end
  end
  stop_times.close
end

all_stops = File.open("public/google_transit_Apr16_Runboard/stops.txt", "r")
stop = all_stops.readlines

stop.each_with_index do |line, index|
  if index < 100
    data = line.split(',')
    mrk = Marker.create(stop_id: data[0], title: data[1], latitude: data[3], longitude: data[4], description: data[2])
    mrk.id = mrk.stop_id
    get_stop(mrk.id)
    mrk.save
  end
end

all_stops.close

