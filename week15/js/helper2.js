
//R
// m = leaflet() |> setView(25.05, 121.5, 12)
m = L.map("map2").setView([25.05,121.5],13)

//R
// m |> addTiles() -> m
// To get tileLayers arguments, in R:
//   m$x[["calls"]][[1]][["args"]] |> jsonlite::toJSON(auto_unbox = T)
L.tileLayer(
  "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",{},{},{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"https://openstreetmap.org\">OpenStreetMap<\/a> contributors, <a href=\"https://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA<\/a>"}
).addTo(m)

//R
// m %>% addMarkers(lng=121.5, lat=25.05, popup="Taipei") -> m
// To get marker arguments in R
// m$x[["calls"]][[2]][["args"]] |> jsonlite::toJSON(auto_unbox = T)
// we get:
// [
// 25.05,121.5,{},{},{},{"interactive":true,"draggable":false,"keyboard":true,"title":"","alt":"","zIndexOffset":0,"opacity":1,"riseOnHover":false,"riseOffset":250},"Taipei",{},{},{},{},{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},{}]
// equivalent to
//[
// (for L.marker)
// 25.05,121.5,
// {"interactive":true,"draggable":false,"keyboard":true,"title":"","alt":"","zIndexOffset":0,"opacity":1,"riseOnHover":false,"riseOffset":250},
// (for marker.bindPopup)
//  "Taipei",
// (for L.tooltip)
// {"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true}]
// L.marker help: https://leafletjs.com/reference.html#marker-l-marker
// Usage: L.marker(<LatLng> latlng, <Marker options> options?)
currentMarker = L.marker([25.05,121.5],{"interactive":true,"draggable":false,"keyboard":true,"title":"","alt":"","zIndexOffset":0,"opacity":1,"riseOnHover":false,"riseOffset":250}).addTo(m)

currentMarker.bindPopup("Taipei")

L.tooltip(
  {"interactive":true,"draggable":false,"keyboard":true,"title":"","alt":"","zIndexOffset":0,"opacity":1,"riseOnHover":false,"riseOffset":250}, m
)
