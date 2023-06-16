document.addEventListener("DOMContentLoaded", function(event) {
    //do work

    //prepare default map
    currentLocation = [25.05, 121.5]
    prepareBaseMap(currentLocation);

    //get current location and update map
    navigator.geolocation
        .getCurrentPosition(successCallback, errorCallback)

    //youbike data
    var youbikeDOM = document.getElementById("youbike-data")
    leaflet.data = JSON.parse(youbikeDOM.textContent)


//exercise
    leaflet.data.forEach((e)=>{
      L.circleMarker(e,{
          radius : 4,
          color : "#0033ff",
          stroke : false,
          fillOpacity : 0.7
      }).bindPopup(
        '<a href="https://www.google.com/maps/@${e.lat},${e.lng},15z">click me</a>').addTo(leaflet.map)});
})
