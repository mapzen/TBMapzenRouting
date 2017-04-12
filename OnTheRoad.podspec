Pod::Spec.new do |s|

  s.name         = "OnTheRoad"
  s.version      = "1.0.0"
  s.summary      = "Request routes from Valhalla routing services, include Mapzen's Turn-by-Turn routing service."

  s.description  = <<-DESC
Valhalla is an open source routing engine and accompanying libraries for use with OpenStreetMap data (https://github.com/valhalla/valhalla). Valhalla also includes tools like time+distance matrix computation and tour optimization (Traveling Salesman).

Mapzen Turn-by-Turn is a navigation service for the world, based on open data, and utilizes the Valhalla tool suite. Add routing to your app and let your users go anywhere on the planet, whether by foot, bike, car, bus, train, or ferry.

The Mapzen Turn-by-Turn API makes it easy to let navigation find its way into your apps, based on road network data from OpenStreetMap and public transit feeds from Transitland. Whether your users need multiple locations, points along a route, custom routing options, or multimodal routing, our API is ready to help.
                   DESC

  s.homepage     = "https://github.com/mapzen/on-the-road_ios"
  s.license      = "MIT"

  s.author             = { "TrailBehind, Inc." => "Jesse@Gaiagps.com", "Mapzen" => "ios-support@mapzen.com" }
  s.social_media_url   = "http://twitter.com/mapzen"

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/mapzen/on-the-road_ios.git", :tag => "v#{s.version}" }

  s.source_files  = "OTRRouting/*.{h,m,c}"

end
