json.array!(@markers) do |marker|
  json.extract! marker, :id, :latitude, :longitude, :description, :address, :title
  json.url marker_url(marker, format: :json)
end
