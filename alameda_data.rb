require 'net/http'
require 'uri'
require 'json'

# Alameda county case data and hospital data JSON
CASE_DATA_JSON = 'https://opendata.arcgis.com/datasets/f6195a2de0b0440c99ceb9290fa95316_0.geojson'
HOSPITAL_DATA_JSON = 'https://opendata.arcgis.com/datasets/7735f633986a4933ab1ff1294bb0e741_0.geojson'

escaped_address = URI.escape(CASE_DATA_JSON) 
uri = URI.parse(escaped_address)

json = Net::HTTP.get(uri)
result = JSON(json)
features = result['features']

case_data = {}
cities = ['Dublin', 'Pleasanton', 'Livermore', 'Fremont', 'Union City']
features.each do |feature|
    properties = feature['properties']
    geography = properties['Geography']
    if(cities.include?(geography))
        case_data[geography] = {'cases' => properties['Cases'], 'Case_Rate' => properties['Case_Rate']}
    end
end

cities.each do |city|
    p "#{city} : " + case_data[city]['cases'] + ' : ' + case_data[city]['Case_Rate']
end

# Alameda county hospital data is not updated daily here.  

# escaped_address = URI.escape(HOSPITAL_DATA_JSON) 
# uri = URI.parse(escaped_address)

# json = Net::HTTP.get(uri)
# result = JSON(json)
# features = result['features']

# hospital_data = {}

# features.each do |feature|
#     properties = feature['properties']
#     p properties.inspect
# end