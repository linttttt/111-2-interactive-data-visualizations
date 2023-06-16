
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
  prepareBaseMap(currentLocation);

};

function errorCallback(error) {
  console.log(error)

};
