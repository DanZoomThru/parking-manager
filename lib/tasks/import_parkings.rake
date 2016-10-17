require 'json'

namespace :import do
  desc "Import parkings from json file"
  file = "db/parkings_input.json"
  task :create_parkings => :environment do
    serialized_parkings = File.read(file)
    parkings = JSON.parse(serialized_parkings)
    parkings.each do |parking|
      park = Parking.new({
        :name => parking["name"],
        :address => parking["address"],
        :available => parking["available"],
        :has_camera => parking["has_camera"],
        :has_watchman => parking["has_watchman"],
        :zip_code => parking["zip_code"],
        :city => parking["city"],
        :main_picture => parking["main_picture"],
        :price_month => parking["price_month"],
        :slug => parking["name"].downcase.gsub(/\s[a-zA-Z]{2}\s/,'-').gsub(/\s/, '-').gsub(/-{2,}/, '-').gsub(/[éèê]/, 'e')
        })
      park.district = park.zip_code[0..1] == "75" ? park.zip_code[3..4] : "0"
      gps = Geokit::Geocoders::GoogleGeocoder.geocode(park.address + ", " + park.city)
      park.lat = gps.ll.split(',').first.to_f
      park.lng = gps.ll.split(',').last.to_f
      park.save
    end
  end
end
