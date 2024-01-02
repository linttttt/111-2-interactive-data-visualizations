
function prepareBaseMap(currentLocation) {
  if(!leaflet.map){
    // create map without declaration makes map a global object
    // equivalent to R's leaflet.map = leaflet() |> setView(...)
    leaflet.map = L.map('map').setView(currentLocation, 13);
    // Add different layers to map via sequence of
      // L.{specific layer}.addTo(map)

      // Add map tiles
      // equivalent to R's leaflet.map |> addTiles(...)
      // L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
      //   maxZoom: 19
      // }).addTo(leaflet.map);

      // Use CartoDB.positron
      var CartoDB_Positron = L.tileLayer(
        'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png', 
        {"errorTileUrl":"","noWrap":false,"detectRetina":false}) 
      CartoDB_Positron.addTo(leaflet.map);

//       // Use Esri.NatGeoWorldMap
//       var Esri_NatGeoWorldMap = L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/NatGeo_World_Map/MapServer/tile/{z}/{y}/{x}', {
// 	attribution: 'Tiles &copy; Esri &mdash; National Geographic, Esri, DeLorme, NAVTEQ, UNEP-WCMC, USGS, NASA, ESA, METI, NRCAN, GEBCO, NOAA, iPC',
// 	maxZoom: 16
// });
//       Esri_NatGeoWorldMap.addTo(leaflet.map);
      
     
  } else {
    leaflet.map.setView(currentLocation, 13);
  }
  

  
  // Add marker
  leaflet.currentLocationMarker =
    L.marker(currentLocation).addTo(leaflet.map);
};

function successCallback(position) {
  console.log(position);
  currentLocation = [position.coords.latitude, position.coords.longitude];
  leaflet.currentLocationMarker.remove();

  findCloset5StationFromCurrentLocation(
    {lat: currentLocation[0], lng: currentLocation[1]}
  )
  prepareBaseMap(currentLocation);
  
};

function errorCallback(error) {
  console.log(error)

};
function distance(p1, p2) {
  return Math.sqrt(
    Math.pow(p1.lat - p2.lat, 2) + Math.pow(p1.lng - p2.lng, 2)
  );
}
function findCloset5StationFromCurrentLocation(currentLocation){

  // compute distance between two positions
  // var positionX = leaflet.data[0]

  // compute each distance from currentLocation
  var stationDistances = leaflet.data.map(function(x){
    return distance(currentLocation,x);
  });

  // Sort stationDistances
  //var sorted_stationDistances= stationDistances.sort()
  var stations = leaflet.data;
  var min5 = [];
    for(var i=0; i<5; i++){
      var minDistance = Math.min(...stationDistances);
      var minIndex = stationDistances.indexOf(minDistance);
      min5.push(stations[minIndex]);
      stationDistances.splice(minIndex,1);
      stations.splice(minIndex,1);
    }

leaflet.min5 = min5
}