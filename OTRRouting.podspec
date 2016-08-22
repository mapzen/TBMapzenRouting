Pod::Spec.new do |s|

  s.name         = "TBMapzenRouting"
  s.version      = "0.2"
  s.summary      = "Request routes from Mapzen Turn-by-Turn routing service"

  s.description  = <<-DESC
Mapzen Turn-by-Turn is a navigation service for the world, based on open data. Add routing to your app and let your users go anywhere on the planet, whether by foot, bike, car, bus, train, or ferry.

The Mapzen Turn-by-Turn API makes it easy to let navigation find its way into your apps, based on road network data from OpenStreetMap and public transit feeds from Transitland. Whether your users need multiple locations, points along a route, custom routing options, or multimodal routing, our API is ready to help.
                   DESC

  s.homepage     = "https://github.com/trailbehind/TBMapzenRouting"
  s.license      = "MIT"

  s.author             = { "TrailBehind, Inc." => "Jesse@Gaiagps.com" }
  s.social_media_url   = "http://twitter.com/gaiagps"

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/trailbehind/TBMapzenRouting.git", :tag => "0.2" }

  s.source_files  = "TBMapzenRouting/*.{h,m,c}"
  s.framework = "CoreLocation"

end
